pub struct Cfg {
    pub cfg: [u16; 64],
}

impl Cfg {
    pub fn new() -> Self {
        Self { cfg: [0u16; 64] }
    }
}

pub trait CfgInfo {
    fn fifo_size(&self) -> u16;
    fn is_programmed(&self) -> bool;
}

impl CfgInfo for Cfg {
    fn fifo_size(&self) -> u16 {
        self.cfg[33]
    }

    fn is_programmed(&self) -> bool {
        self.cfg[48] & 0x0001 != 0
    }
}
