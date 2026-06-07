use std::env;
use std::path::PathBuf;

use image::imageops::FilterType;
use ufde_ip_tools::write_file;

const WIDTH: u32 = 128;
const HEIGHT: u32 = 64;
const WORDS: usize = (WIDTH as usize * HEIGHT as usize) / 8;

fn main() {
    if let Err(error) = run() {
        eprintln!("{error}");
        std::process::exit(1);
    }
}

fn run() -> Result<(), String> {
    let args: Vec<String> = env::args().skip(1).collect();
    if args.is_empty() || args.iter().any(|arg| arg == "-h" || arg == "--help") {
        return Err("usage: img2mif <image> -o <output.mif> -p <preview image>".to_string());
    }

    let input = PathBuf::from(&args[0]);
    let mut output = None;
    let mut preview = None;
    let mut i = 1usize;
    while i < args.len() {
        match args[i].as_str() {
            "-o" | "--output" => {
                i += 1;
                output = args.get(i).map(PathBuf::from);
            }
            "-p" | "--preview" => {
                i += 1;
                preview = args.get(i).map(PathBuf::from);
            }
            other => return Err(format!("unknown argument {other}")),
        }
        i += 1;
    }
    let output = output.ok_or_else(|| "missing -o <output.mif>".to_string())?;
    let preview = preview.ok_or_else(|| "missing -p <preview image>".to_string())?;

    let image = image::open(&input)
        .map_err(|err| format!("failed to open image {}: {err}", input.display()))?;
    let resized = image.resize_exact(WIDTH, HEIGHT, FilterType::Triangle).to_luma8();

    let mut packed = vec![0u8; WORDS];
    let mut preview_image = image::GrayImage::new(WIDTH, HEIGHT);
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let pixel = resized.get_pixel(x, y).0[0];
            let on = pixel < 128;
            preview_image.put_pixel(x, y, image::Luma([if on { 0 } else { 255 }]));
            let bit_index = (y * WIDTH + x) as usize;
            if on {
                packed[bit_index / 8] |= 1 << (7 - (bit_index % 8));
            }
        }
    }

    let mut mif = String::new();
    mif.push_str("WIDTH=8;\n");
    mif.push_str(&format!("DEPTH={WORDS};\n\n"));
    mif.push_str("ADDRESS_RADIX=HEX;\n");
    mif.push_str("DATA_RADIX=HEX;\n\n");
    mif.push_str("CONTENT BEGIN\n");
    for (address, value) in packed.iter().enumerate() {
        mif.push_str(&format!("    {address:03X} : {value:02X};\n"));
    }
    mif.push_str("END;\n");
    write_file(&output, &mif)?;

    if let Some(parent) = preview.parent() {
        std::fs::create_dir_all(parent)
            .map_err(|err| format!("failed to create {}: {err}", parent.display()))?;
    }
    preview_image
        .save(&preview)
        .map_err(|err| format!("failed to write preview {}: {err}", preview.display()))?;

    Ok(())
}
