use super::device_handler::DeviceResult;
use libusb1_sys as libusb_ffi;
use std::os::raw::c_int;

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
            let result = libusb_ffi::libusb_claim_interface(handle, 0);
            if result < 0 {
                libusb_ffi::libusb_close(handle);
                return Err("device open failed".to_string());
            }

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

    fn read_usb_base(&self, endpoint: EndPoint, buffer: &mut [u8]) -> DeviceResult<()> {
        let mut untransferred = buffer.len() as i32;

        loop {
            let mut transferred = 0;
            let result = unsafe {
                libusb_ffi::libusb_bulk_transfer(
                    self.handle,
                    endpoint as u8,
                    buffer.as_ptr() as *mut u8,
                    untransferred,
                    &mut transferred,
                    1000,
                )
            };

            if result != 0 {
                self.try_close();
                return Err("read data failed".to_string());
            }

            if transferred == untransferred {
                break;
            }

            untransferred -= transferred;
        }

        Ok(())
    }

    pub fn read_usb<T>(&self, endpoint: EndPoint, buffer: &mut [T]) -> DeviceResult<()> {
        let buffer = unsafe {
            std::slice::from_raw_parts_mut(
                buffer.as_mut_ptr() as *mut u8,
                buffer.len() * std::mem::size_of_val(buffer),
            )
        };

        self.read_usb_base(endpoint, buffer)
    }

    fn write_usb_base(&self, endpoint: EndPoint, buffer: &[u8]) -> DeviceResult<()> {
        let mut untransferred = buffer.len() as i32;

        loop {
            let mut transferred = 0;
            let result = unsafe {
                libusb_ffi::libusb_bulk_transfer(
                    self.handle,
                    endpoint as u8,
                    buffer.as_ptr() as *mut u8,
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
        }

        Ok(())
    }

    pub fn write_usb<T>(&self, endpoint: EndPoint, buffer: &[T]) -> DeviceResult<()> {
        let buffer = unsafe {
            std::slice::from_raw_parts(
                buffer.as_ptr() as *const u8,
                buffer.len() * std::mem::size_of_val(buffer),
            )
        };

        self.write_usb_base(endpoint, buffer)
    }
}
