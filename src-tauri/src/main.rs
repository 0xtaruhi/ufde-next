// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

mod vlfd;

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![program_fpga])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}

#[tauri::command]
async fn program_fpga(bitfile: String) -> Result<(), String> {
    let mut program_handler = vlfd::ProgramHandler::new();
    program_handler.open_device()?;
    program_handler.program(std::path::Path::new(&bitfile))?;
    program_handler.close_device()?;
    Ok(())
}
