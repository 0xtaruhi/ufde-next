use std::env;
use std::path::PathBuf;

use ufde_ip_tools::{
    generate_bram_verilog, generate_pll_verilog, output_path_for_mif, parse_mif,
    sanitize_module_name, write_file,
};

fn main() {
    match run() {
        Ok(message) => {
            println!("{{\"success\":true,\"message\":\"{}\"}}", escape_json(&message));
        }
        Err(error) => {
            eprintln!("{error}");
            println!("{{\"success\":false,\"error\":\"{}\"}}", escape_json(&error));
            std::process::exit(1);
        }
    }
}

fn run() -> Result<String, String> {
    let mut args = env::args().skip(1);
    match args.next().as_deref() {
        Some("pll") => run_pll(args.collect()),
        Some("bram") => run_bram(args.collect()),
        Some("-h") | Some("--help") | None => Err(usage()),
        Some(other) => Err(format!("unknown command {other}\n{}", usage())),
    }
}

fn run_pll(args: Vec<String>) -> Result<String, String> {
    let mut divide = None;
    let mut gates = None;
    let mut output = None;
    let mut i = 0usize;
    while i < args.len() {
        match args[i].as_str() {
            "--divide" => {
                i += 1;
                divide = args.get(i).and_then(|value| value.parse::<usize>().ok());
            }
            "--gates" => {
                i += 1;
                gates = args.get(i).and_then(|value| value.parse::<usize>().ok());
            }
            "--output" => {
                i += 1;
                output = args.get(i).map(PathBuf::from);
            }
            other => return Err(format!("unknown pll argument {other}")),
        }
        i += 1;
    }

    let divide = divide.ok_or_else(|| "missing --divide".to_string())?;
    let gates = gates.ok_or_else(|| "missing --gates".to_string())?;
    let output = output.ok_or_else(|| "missing --output".to_string())?;
    if !matches!(divide, 2 | 4 | 8 | 16) {
        return Err(format!("unsupported divide value {divide}"));
    }
    if !matches!(gates, 30 | 50) {
        return Err(format!("unsupported FPGA gates value {gates}"));
    }

    let module_name = output
        .file_stem()
        .and_then(|value| value.to_str())
        .map(sanitize_module_name)
        .unwrap_or_else(|| format!("PLL_{divide}_{gates}"));
    let content = generate_pll_verilog(&module_name, divide, gates);
    write_file(&output, &content)?;
    Ok(format!("generated {}", output.display()))
}

fn run_bram(args: Vec<String>) -> Result<String, String> {
    let mif_path = args
        .first()
        .map(PathBuf::from)
        .ok_or_else(|| "missing MIF path".to_string())?;
    let mif = parse_mif(&mif_path)?;
    let output = output_path_for_mif(&mif_path);
    let content = generate_bram_verilog(&mif_path, &mif);
    write_file(&output, &content)?;
    Ok(format!("generated {}", output.display()))
}

fn usage() -> String {
    "usage: ip_generator pll --divide <2|4|8|16> --gates <30|50> --output <file>\n       ip_generator bram <file.mif>".to_string()
}

fn escape_json(value: &str) -> String {
    value
        .replace('\\', "\\\\")
        .replace('"', "\\\"")
        .replace('\n', "\\n")
}
