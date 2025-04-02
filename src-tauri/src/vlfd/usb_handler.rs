use super::device_handler::DeviceResult;
use libusb1_sys as libusb_ffi;
use std::os::raw::c_int;

use std::ffi::CStr;
use std::os::raw::c_char;

//The address of the endpoint described by this descriptor.
//Bits 0:3 are the endpoint number. Bits 4:6 are reserved. Bit 7 indicates direction
//#define EP2 (LIBUSB_ENDPOINT_OUT | 2)
//#define EP6 (LIBUSB_ENDPOINT_IN| 6)

// #define EP2 2  // FIFO_WR
// #define EP4 4  // COMMAND_WR
// #define EP6 6  // FIFO_RD
// #define EP8 8  // sync result
#[derive(Clone, Copy)]
pub enum EndPoint {
    EP2 = 0x02,
    EP4 = 0x04,
    EP6 = 0x86,
    EP8 = 0x88,
}

const VID: u16 = 0x2200;
const PID: u16 = 0x2008;

pub struct UsbHandler {
    handle: *mut libusb_ffi::libusb_device_handle,
}

impl UsbHandler {
    pub fn new() -> UsbHandler {
        UsbHandler {
            handle: std::ptr::null_mut(),
        }
    }

    pub fn is_opened(&self) -> bool {
        !self.handle.is_null()
    }

    pub fn open(&mut self) -> DeviceResult<()> {
        unsafe {
            libusb_ffi::libusb_init(std::ptr::null_mut());
        }
        
        let handle =
            unsafe { libusb_ffi::libusb_open_device_with_vid_pid(std::ptr::null_mut(), VID, PID) };
        
        if handle.is_null() {
            return Err("device open failed".to_string());
        }

        unsafe {
            libusb_ffi::libusb_reset_device(handle);
        }

        unsafe {
            let result = libusb_ffi::libusb_claim_interface(handle, 0);

            if result < 0 {
                let error_name = libusb_ffi::libusb_error_name(result);
                let error_str = convert_c_char_to_string(error_name);
                libusb_ffi::libusb_close(handle);
                return Err(format!("device open failed (error {result}, {error_str})").to_string());
            };

            let error_check = |r: c_int| {
                if r < 0 {
                    self.try_close();
                    return Err("device open failed".to_string());
                }
                Ok(())
            };
            
            error_check(libusb_ffi::libusb_clear_halt(handle, EndPoint::EP2 as u8))?;
            error_check(libusb_ffi::libusb_clear_halt(handle, EndPoint::EP4 as u8))?;
            error_check(libusb_ffi::libusb_clear_halt(handle, EndPoint::EP6 as u8))?;
            error_check(libusb_ffi::libusb_clear_halt(handle, EndPoint::EP8 as u8))?;
        }

        self.handle = handle;
        Ok(())
    }

    /// This function is used to close the device. It will release the interface.
    pub fn try_close(&self) {
        if !self.handle.is_null() {
            unsafe {
                libusb_ffi::libusb_release_interface(self.handle, 0);
                libusb_ffi::libusb_close(self.handle);
            }
        }

        unsafe {
            libusb_ffi::libusb_exit(std::ptr::null_mut());
        }
    }

    pub fn close(&mut self) -> DeviceResult<()> {
        if !self.handle.is_null() {
            unsafe {
                let result = libusb_ffi::libusb_release_interface(self.handle, 0);
                if result < 0 {
                    return Err("device close failed".to_string());
                }

                libusb_ffi::libusb_close(self.handle);
            }
        } else {
            return Err("device not opened".to_string());
        }

        unsafe {
            libusb_ffi::libusb_exit(std::ptr::null_mut());
        }

        Ok(())
    }

    // =========================================================================
    // =========================== READ OPERATION ==============================
    // =========================================================================
    fn read_usb_base(&self, endpoint: EndPoint, buffer: &mut [u8]) -> DeviceResult<()> {
        let mut untransferred = buffer.len() as i32;
        let mut buffer_current_ptr = buffer.as_mut_ptr();

        loop {
            let mut transferred = 0;
            let result = unsafe {
                libusb_ffi::libusb_bulk_transfer(
                    self.handle,
                    endpoint as u8,
                    buffer_current_ptr,
                    untransferred,
                    &mut transferred,
                    1000,
                )
            };
            // [REF.] SMIMS_iobase.cpp:210
            // iRet = libusb_bulk_transfer(dev_handle, EndPoint, (unsigned char *)ptr, Size, &WriteSize, 1000);

            if result != 0 {
                self.try_close();
                return Err("read data failed".to_string());
            }

            if transferred == untransferred {
                break;
            }

            untransferred -= transferred;
            buffer_current_ptr = unsafe { buffer_current_ptr.add(transferred as usize) };
        }

        Ok(())
    }

    pub fn read_usb<T>(&self, endpoint: EndPoint, buffer: &mut [T]) -> DeviceResult<()> {
        let buffer = unsafe {
            std::slice::from_raw_parts_mut(
                buffer.as_mut_ptr() as *mut u8,
                std::mem::size_of_val(buffer),
            )
        };

        self.read_usb_base(endpoint, buffer)
    }

    // =========================================================================
    // =========================== WRITE OPERATION =============================
    // =========================================================================

    pub fn write_usb_base(&self, endpoint: EndPoint, buffer: &[u8]) -> DeviceResult<()> {
        let mut untransferred = buffer.len() as i32;
        let mut buffer_current_ptr = buffer.as_ptr();

        loop {
            let mut transferred = 0;
            let result = unsafe {
                libusb_ffi::libusb_bulk_transfer(
                    self.handle,
                    endpoint as u8,
                    buffer_current_ptr as *mut u8,
                    untransferred,
                    &mut transferred,
                    1000,
                )
            };

            if result != 0 {
                self.try_close();
                return Err("write usb failed".to_string());
            }

            if transferred == untransferred {
                break;
            }

            untransferred -= transferred;
            buffer_current_ptr = unsafe { buffer_current_ptr.add(transferred as usize) };
        }

        Ok(())
    }

    pub fn write_usb<T>(&self, endpoint: EndPoint, buffer: &[T]) -> DeviceResult<()> {
        let buffer = unsafe {
            std::slice::from_raw_parts(buffer.as_ptr() as *const u8, std::mem::size_of_val(buffer))
        };

        self.write_usb_base(endpoint, buffer)
    }
}

// Helper function
fn convert_c_char_to_string(ptr: *const c_char) -> String {
    unsafe {
        // Create a CStr reference from the raw pointer.
        // This assumes that the pointer is non-null and points to a null-terminated string.
        let c_str = CStr::from_ptr(ptr);
        // Convert the CStr into a Rust String.
        // to_string_lossy() converts non-UTF-8 sequences into replacement characters.
        c_str.to_string_lossy().into_owned()
    }
}