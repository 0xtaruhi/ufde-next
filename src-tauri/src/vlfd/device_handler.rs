use super::constants;
use super::cfg::Cfg;
use super::cfg::CfgInfo;
use super::usb_handler::EndPoint;
use super::usb_handler::UsbHandler;

pub struct DeviceHandler {
    pub usb: UsbHandler,
    pub cfg: Cfg,                   // Configuration API
    encrypt_table: [u16; 32],       // Encrypt table, uint16_t x 32
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

    pub fn init(&mut self) -> DeviceResult<()> {
        self.encrypt_table_read()?;
        self.decoded_encrypt_table();

        self.read_cfg()?;

        Ok(())
    }

    pub fn engine_reset(&self) -> DeviceResult<bool> {
        let command = [0x02u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        return Ok(true);
    }

    pub fn open(&mut self) -> DeviceResult<()> {
        self.usb.open()?;
        Ok(())
    }

    pub fn close(&mut self) -> DeviceResult<()> {
        self.usb.close()?;
        Ok(())
    }

    // =========================================================================
    // ============================== VLFD =====================================
    // =========================================================================

    /**
     * - VLFD_IO_ProgramFPGA (in another file)
     * - VLFD_IO_Open
     * - VLFD_IO_WriteReadData
     * - VLFD_IO_Close
     */

    // Note: program FPGA is implemented separately -> (program_handler)
    /**
     
     */
    pub fn io_open(&mut self) -> DeviceResult<()>{
        println!("1");
        if self.usb.is_opened() {
            self.usb.close()?;
        }

        self.usb.open()?;

        // Read SMIMS encrypt table
        // self.encrypt_table_read();
        // self.decoded_encrypt_table();
        
        // Read the CFG from SMIMS engine 
        // self.read_cfg();    // (note that decypt happens inside of read_cfg)
        
        // The three tasks mentioned above can be done with:
        self.init()?;

        // Check SMIMS version
        if (self.cfg.smims_version() as u16) < constants::SMIMS_VERSION {
            return Err("board version error".to_string());
        }
        
        // Check if FPGA is programmed
        // cfg.is_programmed <==> SMIMS_isFPGAProrgam
        if !self.cfg.is_programmed() {
            return Err("FGPA is not programmed".to_string());
        }

        println!("{}", self.cfg.is_programmed());

        // Check VeriComm ability
        if !self.cfg.vericomm_ability() {
            return Err("VeriComm mode is not supported".to_string());
        }

        // Do licence key stuff...
        // let security_key = self.cfg.get_security_key();
        // println!("Security key {:#04x}", security_key);
        // let licence_key = self.licence_gen(security_key, 0x14b8);
        // println!("Licence key: {:#04x}", licence_key);
        self.cfg.set_licence_key(0xff40);

        // [IMPORTANT] Configure VeriComm for IO
        // Refer to SMIMS_VLFD.cpp:344
        let clock_high_delay = 11u16;
        let clock_low_delay = 11u16;
        self.cfg.set_vericomm_clock_highdelay(clock_high_delay);
        self.cfg.set_vericomm_clock_lowdelay(clock_low_delay);
        self.cfg.set_vericomm_isv(0);
        self.cfg.set_vericomm_clock_check(false);   // Disable regular clock check
        self.cfg.set_mode_selector(0);              // Set SMIMS Engine I/O to VeriComm Mode

        // Encrypt the newly configured CFG and prepare it for uploading
        self.write_cfg()?;
        
        // Send command to activate VeriComm module
        self.activate_vericomm()?;
        Ok(())
    }

    pub fn io_write_read_data(&mut self) -> DeviceResult<()> {
        // let mut buffer = Vec::with_capacity(write_buffer.len()); // Create a buffer with the same capacity as write_buffer
        // buffer.resize(write_buffer.len(), Default::default());
        // buffer.clone_from_slice(write_buffer); // Clone the contents of write_buffer into buffer
//         {
//         let mut buffer = [0u16; 16];
//         self.encrypt(&mut buffer);
//         self.usb.write_usb(EndPoint::EP2, &buffer)?;
//         let mut another_buf = [0u16; 16];
//         self.usb.read_usb(EndPoint::EP6, &mut another_buf)?;
//         self.decrypt(&mut another_buf);
// }
        // let mut buffer = [0u16; 16];
        // println!("- {:?}", buffer);
        // self.encrypt(&mut buffer);
        // println!("- {:?}", buffer);
        // self.usb.write_usb(EndPoint::EP2, &buffer)?;
        // println!("- {:?}", buffer);
        // let mut buffer = [0u16; 16];
        // self.usb.read_usb(EndPoint::EP6, &mut buffer)?;
        // println!("- {:?}", buffer);
        // self.decrypt(&mut buffer);
        let mut buffer = [0u16; 4];
        self.encrypt(&mut buffer);
        self.fifo_write(& buffer)?;
        self.fifo_read(&mut buffer)?;
        self.decrypt(&mut buffer);

        // Print the bit array
        // Convert the buffer into a bit array (vector of 0s and 1s)
        let bit_array: Vec<u8> = buffer.iter()
        .flat_map(|&num| (0..16).map(move |i| ((num >> (15 - i)) & 1) as u8))
        .collect();

        // Print the bit array
        for bit in bit_array {
            print!("{}", bit);  // Print each bit as 0 or 1
        }


        // // Ensure that the lengths match before copying
        // if read_buffer.len() == buffer.len() {
        //     println!("Test");
        //     read_buffer.copy_from_slice(&buffer); // Copy contents from buffer into read_buffer
        // } else {
        //     // Handle the case where lengths don't match (you may want to resize read_buffer)
        //     return Err("data length read from FIFO does not match".to_string());
        // }

        Ok(())
    }   

    /**
      Gacefully exists from IO mode & closes the device.
      */
    pub fn io_close(&mut self) -> DeviceResult<bool> {
        if !self.usb.is_opened() {
            return Ok(true)
        }

        // End Application Mode
        self.command_active()?;
        self.close()?;

        return Ok(true);
    }

    // =========================================================================
    // ========================== Data Transfer API ============================
    // =========================================================================
    
    pub fn fifo_write<T>(&self, buffer: &[T]) -> DeviceResult<()> {
        self.usb.write_usb(EndPoint::EP2, buffer)?;
        Ok(())
    }

    pub fn fifo_read<T>(&self, buffer: &mut [T]) -> DeviceResult<()> {
        self.usb.read_usb(EndPoint::EP6, buffer)?;
        Ok(())
    }

    // =========================================================================
    // ============================ Command API ================================
    // =========================================================================

    pub fn sync_delay(&self) -> DeviceResult<()> {
        let start = std::time::Instant::now();
        loop {
            let mut buffer = [0u8; 1];
            self.usb.write_usb(EndPoint::EP4, &buffer)?;
            self.usb.read_usb(EndPoint::EP8, &mut buffer)?;
            if buffer[0] != 0 {
                break;
            }
            if start.elapsed() > std::time::Duration::from_secs(1) {
                return Err("sync delay timeout".to_string());
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

    /**
     Reads, decrypts, and stores CFG from SMIMS device to cfg
    */
    pub fn read_cfg(&mut self) -> DeviceResult<()> {
        let mut cfg = [0u16; 64];
        // Read Cfg Space
        self.sync_delay()?;
        let command = [0x01u8, 0x01u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        self.usb.read_usb(EndPoint::EP6, &mut cfg)?;
        self.command_active()?;
        self.decrypt(&mut cfg);
        self.cfg = Cfg { cfg };
        Ok(())
    }

    /**
     Writes the current CFG back to SMIMS
    */
    pub fn write_cfg(&mut self) -> DeviceResult<()> {
        let mut cfg = self.cfg.cfg.clone();
        self.sync_delay()?;
        self.encrypt(&mut cfg);
        let command = [0x01u8, 0x11u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        if let Err(e) = self.usb.write_usb(EndPoint::EP2, &cfg) {
            println!("Error {e}");
        }
        self.command_active()?;
        Ok(())
    }

    pub fn activate_fpga_programmer(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x02u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_vericomm(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x03u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_veri_instrument(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x08u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_verilink(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x09u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_veri_soc(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x0au8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_vericomm_pro(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x0bu8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_veri_sdk(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x04u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_flash_read(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x05u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    pub fn activate_flash_write(&self) -> DeviceResult<()> {
        self.sync_delay()?;
        let command = [0x01u8, 0x15u8];
        self.usb.write_usb(EndPoint::EP4, &command)?;
        Ok(())
    }

    // =========================================================================
    // ============================ Encrypt API ================================
    // =========================================================================
    
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
                std::mem::size_of_val(buffer) / 2,
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
                std::mem::size_of_val(buffer) / 2,
            )
        };

        self.encrypt_base(buffer);
    }

    pub fn licence_gen(&self, security_key: u16, customer_id: u16) -> u16 {
        let mut temp: u32 = 0;
        let mut i: u16 = security_key & 0x0003;
        let mut j: u16 = (customer_id & 0x000f) << 4;

        j >>= i;
        j = (j >> 4) | (j & 0x000f);
        temp |= (j as u32) << 16;

        i = (security_key & 0x0030) >> 4;
        j = customer_id & 0x00f0;
        j >>= i;
        j = (j >> 4) | (j & 0x000f);
        temp |= (j as u32) << 20;

        i = (security_key & 0x0300) >> 8;
        j = (customer_id & 0x0f00) >> 4;
        j >>= i;
        j = (j >> 4) | (j & 0x000f);
        temp |= (j as u32) << 24;

        i = (security_key & 0x3000) >> 12;
        j = (customer_id & 0xf000) >> 8;
        j >>= i;
        j = (j >> 4) | (j & 0x000f);
        temp |= (j as u32) << 28;

        temp >>= 11;
        // i = ~((temp >> 16) | (temp & 0x0000ffff)) as u16;
        i = !((temp >> 16) | (temp & 0x0000ffff)) as u16;

        return i;
    }
}

fn decode_encrypt_table(encrypt_table: &mut [u16]) {
    encrypt_table[0] = !encrypt_table[0];

    for i in 1..encrypt_table.len() {
        encrypt_table[i] ^= encrypt_table[i - 1];
    }
}
