// The VLFD module mirrors the vendor hardware API and keeps several IO/config
// entry points that are not wired into the current Tauri commands yet.
#![allow(dead_code)]

pub mod constants;

mod program_handler;
pub use program_handler::ProgramHandler;

pub mod cfg;
pub mod device_handler;
pub mod serial;
mod usb_handler;
