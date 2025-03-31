use super::cfg::CfgInfo;
use super::device_handler::DeviceHandler;
use super::usb_handler::EndPoint;

use std::io::BufRead;

use super::device_handler::DeviceResult;

pub struct ProgramHandler {
   pub device: DeviceHandler,
}

impl ProgramHandler {
    pub fn new() -> ProgramHandler {
        ProgramHandler {
            device: DeviceHandler::new(),
        }
    }

    pub fn open_device(&mut self) -> DeviceResult<()> {
        self.device.open()?;
        self.device.init()?;
        Ok(())
    }

    pub fn close_device(&mut self) -> DeviceResult<()> {
        self.device.close()?;
        Ok(())
    }

    pub fn program(&mut self, bitfile: &std::path::Path) -> DeviceResult<()> {
        // Check if file is readable
        let file = std::fs::File::open(bitfile).map_err(|_e| "bitfile open failed")?;

        let lines = std::io::BufReader::new(file).lines();
        let mut program_data = Vec::with_capacity(lines.size_hint().0 * 2);

        for line in lines {
            let line = line.map_err(|_err| "bitfile read failed")?;

            let line = line.trim();
            if line.is_empty() {
                continue;
            }

            let mut data = 0u16;

            for c in line.as_bytes().iter() {
                match *c {
                    b'_' => {
                        program_data.push(data);
                        data = 0;
                        continue;
                    }
                    b' ' | b'\t' => {
                        break;
                    }
                    _ => {}
                }

                let remapped = char_remap(c);
                if remapped.is_none() {
                    return Err("invalid char in bitfile".to_string());
                }

                data = (data << 4) | (remapped.unwrap() as u16);
            }
            program_data.push(data);
        }
        self.device.encrypt(&mut program_data);
        let program_data = &program_data;

        self.device.activate_fpga_programmer()?;

        let fifo_size = self.device.cfg.fifo_size() as usize;

        let max_single_transfer_size = fifo_size * 2;
        {
            let mut offset = 0;

            while offset < program_data.len() {
                let mut transfer_size = max_single_transfer_size;
                if offset + transfer_size > program_data.len() {
                    transfer_size = program_data.len() - offset;
                }

                let transfer_data = &program_data[offset..offset + transfer_size];
                self.device.usb.write_usb(EndPoint::EP2, transfer_data)?;
                offset += transfer_size;
            }
        }

        self.device.command_active()?;
        self.device.read_cfg()?;

        let programmed = self.device.cfg.is_programmed();
        if !programmed {
            return Err("fpga programming failed".to_string());
        }

        Ok(())
    }
}

fn char_remap(c: &u8) -> Option<u8> {
    let result = match c {
        0x30..=0x39 => c - 0x30,
        0x41..=0x46 => c - 0x37,
        0x61..=0x66 => c - 0x57,
        _ => return None,
    };

    Some(result)
}
