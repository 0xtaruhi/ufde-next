use std::{error::Error as StdError, fmt::Display};

#[derive(Debug)]
pub enum DeviceError {
    Open,
    Read(String),
    Write(String),
    Close(String),
    Other(String),
}

impl Display for DeviceError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match *self {
            DeviceError::Open => write!(f, "Device Open error"),
            DeviceError::Read(ref s) => write!(f, "Device read error: {}", s),
            DeviceError::Write(ref s) => write!(f, "Device write error: {}", s),
            DeviceError::Close(ref s) => write!(f, "Device close error {}", s),
            DeviceError::Other(ref s) => write!(f, "Device other error: {}", s),
        }
    }
}

impl StdError for DeviceError {
    fn description(&self) -> &str {
        match *self {
            DeviceError::Open => "Device Open error",
            DeviceError::Read(_) => "Device read error",
            DeviceError::Write(_) => "Device write error",
            DeviceError::Close(_) => "Device close error",
            DeviceError::Other(_) => "Device other error",
        }
    }

    fn cause(&self) -> Option<&dyn StdError> {
        None
    }
}
