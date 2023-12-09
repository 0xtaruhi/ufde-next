use super::cfg::Cfg;
use super::usb_handler::EndPoint;
use super::usb_handler::UsbHandler;

pub struct DeviceHandler {
    pub usb: UsbHandler,
    pub cfg: Cfg,
    encrypt_table: [u16; 32],
    encode_index: usize,
    decode_index: usize,
}

pub type DeviceResult<T> = Result<T, String>;

impl DeviceHandler {
    pub fn new() -> Self {
        Self {
            usb: UsbHandler::new(),
            encrypt_table: [0u16; 32],
            encode_index: 0,
            decode_index: 0,
            cfg: Cfg::new(),
        }
    }

    pub fn open(&mut self) -> DeviceResult<()> {
        self.usb.open()?;
        Ok(())
    }

    pub fn close(&mut self) -> DeviceResult<()> {
        self.usb.close()?;
        Ok(())
    }

    pub fn sync_delay(&self) -> DeviceResult<()> {
        loop {
            let mut buffer = [0u8; 1];
            self.usb.write_usb(EndPoint::EP4, &buffer)?;
            self.usb.read_usb(EndPoint::EP8, &mut buffer)?;

            if buffer[0] != 0 {
                break;
            }
        }

        Ok(())
    }

    pub fn command_active(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let buffer = [0x01u8, 0x00u8];

        self.usb.write_usb(EndPoint::EP4, &buffer)?;
        Ok(())
    }

    pub fn encrypt_table_read(&mut self) -> DeviceResult<()> {
        self.sync_delay()?;

        let command = [0x01u8, 0x0fu8];
        self.usb.write_usb(EndPoint::EP4, &command)?;

        let buffer = self.encrypt_table.as_mut();
        self.usb.read_usb(EndPoint::EP6, buffer)?;

        Ok(())
    }

    pub fn decoded_encrypt_table(&mut self) {
        decode_encrypt_table(&mut self.encrypt_table);
        self.encode_index = 0;
        self.decode_index = 0;
    }

    pub fn read_cfg(&mut self) -> DeviceResult<()> {
        let mut cfg = [0u16; 64];
        // Read Cfg Space
        {
            self.sync_delay()?;
            let command = [0x01u8, 0x01u8];
            self.usb.write_usb(EndPoint::EP4, &command)?;
            self.usb.read_usb(EndPoint::EP6, &mut cfg)?;
            self.command_active()?;
        }

        self.decrypt(&mut cfg);
        self.cfg = Cfg { cfg };

        Ok(())
    }

    fn decrypt_base(&mut self, buffer: &mut [u16]) {
        let encrypt_key = &self.encrypt_table[16..32];
        let mut decode_index = self.decode_index;

        for buffer_val in buffer {
            *buffer_val ^= encrypt_key[decode_index];
            decode_index = (decode_index + 1) & 0x0f;
        }

        self.decode_index = decode_index;
    }

    pub fn decrypt<T>(&mut self, buffer: &mut [T]) {
        let buffer = unsafe {
            std::slice::from_raw_parts_mut(
                buffer.as_mut_ptr() as *mut u16,
                buffer.len() * std::mem::size_of_val(buffer) / 2,
            )
        };

        self.decrypt_base(buffer);
    }

    fn encrypt_base(&mut self, buffer: &mut [u16]) {
        let encrypt_key = &self.encrypt_table[0..16];
        let mut encode_index = self.encode_index;

        for buffer_val in buffer {
            *buffer_val ^= encrypt_key[encode_index];
            encode_index = (encode_index + 1) & 0x0f;
        }

        self.encode_index = encode_index;
    }

    pub fn encrypt<T>(&mut self, buffer: &mut [T]) {
        let buffer = unsafe {
            std::slice::from_raw_parts_mut(
                buffer.as_mut_ptr() as *mut u16,
                buffer.len() * std::mem::size_of_val(buffer) / 2,
            )
        };

        self.encrypt_base(buffer);
    }

    pub fn init(&mut self) -> DeviceResult<()> {
        self.encrypt_table_read()?;
        self.decoded_encrypt_table();

        self.read_cfg()?;

        Ok(())
    }

    pub fn activate_fpga_programmer(&self) -> DeviceResult<()> {
        self.sync_delay()?;

        let command = [0x01u8, 0x02u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;

        Ok(())
    }
}

fn decode_encrypt_table(encrypt_table: &mut [u16]) {
    encrypt_table[0] = !encrypt_table[0];

    for i in 1..encrypt_table.len() {
        encrypt_table[i] ^= encrypt_table[i - 1];
    }
}
