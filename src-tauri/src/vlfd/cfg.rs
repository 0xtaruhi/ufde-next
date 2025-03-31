/**
  Configuration Space API
 */

pub struct Cfg {
    pub cfg: [u16; 64],
}

impl Cfg {
    pub fn new() -> Self {
        Self { cfg: [0u16; 64] }
    }

    pub fn set_vericomm_clock_highdelay(&mut self, clock_highdelay: u16) {
        self.cfg[0] = clock_highdelay;
    }

    pub fn set_vericomm_clock_lowdelay(&mut self, clock_lowdelay: u16) {
        self.cfg[1] = clock_lowdelay;
    }

    pub fn set_vericomm_isv(&mut self, value: u16) {
        let temp1: u16 = self.cfg[2] & 0x0001;
        let temp2: u16 = (value << 4) & 0x00f0;
        self.cfg[2] = temp1 |  temp2;
    }
    
    pub fn set_vericomm_clock_check(&mut self, check: bool) {
        if check {
            self.cfg[2] |= 0x0001;
        } else {
            self.cfg[2] &= 0xfffe;
        }
    }

    pub fn set_veri_sdk_channel_selector(&mut self, select: u8) {
        self.cfg[3] &= 0xff00;
        self.cfg[3] |= select as u16;
    }

    pub fn set_mode_selector(&mut self, select: u8) {
        self.cfg[3] &= 0x00ff;
        self.cfg[3] |= (select as u16) << 8;
    }

    pub fn set_flash_begin_block_addr(&mut self, address: u16) {
        self.cfg[4] = address;
    }

    pub fn set_flash_begin_cluster_addr(&mut self, address: u16) {
        self.cfg[5] = address;
    }

    pub fn set_flash_read_end_block_addr(&mut self, address: u16) {
        self.cfg[6] = address;
    }

    pub fn set_flash_read_end_cluster_addr(&mut self, address: u16) {
        self.cfg[7] = address;
    }

    pub fn set_licence_key(&mut self, licence_key: u16) {
        self.cfg[31] = licence_key;
    }
}

pub trait CfgInfo {
    // Getter methods
    fn get_vericomm_clock_highdelay(&self) -> u16;
    fn get_vericomm_clock_lowdelay(&self) -> u16;
    fn get_vericomm_isv(&self) -> u8;
    fn get_vericomm_clockcheck_enable(&self) -> bool;
    fn get_veri_sdk_channel_selector(&self) -> u8;
    fn get_mode_selector(&self) -> u8;
    fn get_flash_begin_block_addr(&self) -> u16;
    fn get_flash_begin_cluster_addr(&self) -> u16;
    fn get_flash_read_end_block_addr(&self) -> u16;
    fn get_flash_read_end_cluster_addr(&self) -> u16;
    fn get_security_key(&self) -> u16;

    fn smims_version(&self) -> i32;
    fn smims_majorversion(&self) -> i32;
    fn smims_subversion(&self) -> i32;
    fn smims_subsubversion(&self) -> i32;    

    fn fifo_size(&self) -> u16;
    fn flash_total_block(&self) -> u16;
    fn flash_block_size(&self) -> u16;
    fn flash_cluster_size(&self) -> u16;

    fn vericomm_ability(&self) -> bool;
    fn veri_instrument_ability(&self) -> bool;
    fn veri_link_ability(&self) -> bool;
    fn veri_soc_ability(&self) -> bool;
    fn vericomm_pro_ability(&self) -> bool;
    fn veri_sdk_ability(&self) -> bool;

    fn is_programmed(&self) -> bool;
    fn is_pcb_connect(&self) -> bool;
    fn is_vericomm_clockcontinue(&self) -> bool;
}

impl CfgInfo for Cfg {
    fn get_vericomm_clock_highdelay(&self) -> u16 {
        self.cfg[0]
    }

    fn get_vericomm_clock_lowdelay(&self) -> u16 {
        self.cfg[1]
    }

    fn get_vericomm_isv(&self) -> u8 {
        let mut temp: u16 = self.cfg[2] >> 4;
        temp &= 0x000f;
        return temp as u8;
    }

    fn get_vericomm_clockcheck_enable(&self) -> bool {
        if self.cfg[2] & 0x0001 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn get_veri_sdk_channel_selector(&self) -> u8 {
        (self.cfg[3] & 0xFF) as u8
    }

    fn get_mode_selector(&self) -> u8 {
        (self.cfg[3] >> 8) as u8
    }

    fn get_flash_begin_block_addr(&self) -> u16 {
        self.cfg[4]
    }

    fn get_flash_begin_cluster_addr(&self) -> u16 {
        self.cfg[5]
    }

    fn get_flash_read_end_block_addr(&self) -> u16 {
        self.cfg[6]
    }

    fn get_flash_read_end_cluster_addr(&self) -> u16 {
        self.cfg[7]
    }

    fn get_security_key(&self) -> u16 {
        self.cfg[31]
    }

    // SMIMS version getter methods
    fn smims_version(&self) -> i32 {
        self.cfg[32].into()
    }

    fn smims_majorversion(&self) -> i32 {
        (self.cfg[32] >> 8).into()
    }

    fn smims_subversion(&self) -> i32 {
        ((self.cfg[32] >> 4) & 0xF).into()
    }

    fn smims_subsubversion(&self) -> i32 {
        (self.cfg[32] & 0xF).into()
    }

    // Internal size methods
    fn fifo_size(&self) -> u16 {
        self.cfg[33]
    }

    fn flash_total_block(&self) -> u16 {
        self.cfg[34]
    }

    fn flash_block_size(&self) -> u16 {
        self.cfg[35]
    }

    fn flash_cluster_size(&self) -> u16 {
        self.cfg[36]
    }

    // State methods cfg[37]
    fn vericomm_ability(&self) -> bool {
        if self.cfg[37] & 0x0001 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn veri_instrument_ability(&self) -> bool {
        if self.cfg[37] & 0x0002 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn veri_link_ability(&self) -> bool {
        if self.cfg[37] & 0x0004 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn veri_soc_ability(&self) -> bool {
        if self.cfg[37] & 0x0008 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn vericomm_pro_ability(&self) -> bool {
        if self.cfg[37] & 0x0010 != 0 {
            return true;
        } else {
            return false;
        }
    }

    fn veri_sdk_ability(&self) -> bool {
        if self.cfg[37] & 0x0100 != 0 {
            return true;
        } else {
            return false;
        }
    }

    // =========================================================================
    fn is_programmed(&self) -> bool {
        self.cfg[48] & 0x0001 != 0
    }

    fn is_pcb_connect(&self) -> bool {
        if self.cfg[48] & 0x0100 != 0 {
            return false;
        } else {
            return true;
        }
    }

    fn is_vericomm_clockcontinue(&self) -> bool {
        if self.cfg[49] & 0x0001 != 0 {
            return false;
        } else {
            return true;
        }
    }

}
