use std::io::{BufRead, Write};
use regex::Regex;

#[derive(serde::Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SimulationArgs {
    pub project_dir: String,
    pub modelsim_dir: String,
    pub netlist_path: String,
    pub testbench_path: String,
    pub top_module: String,
    pub edalib_dir: String,
    pub custom_simlib_path: Option<String>,
}

fn preprocess_netlist(input_path: &std::path::Path, output_path: &std::path::Path) -> Result<(), String> {
    let input_file = std::fs::File::open(input_path)
        .map_err(|e| format!("failed to open netlist: {}", e))?;
    let reader = std::io::BufReader::new(input_file);
    
    let mut output_file = std::fs::File::create(output_path)
        .map_err(|e| format!("failed to create preprocessed netlist: {}", e))?;
    
    let bram_params: Vec<&str> = vec![
        "init_00", "init_01", "init_02", "init_03",
        "init_04", "init_05", "init_06", "init_07",
        "init_08", "init_09", "init_0a", "init_0b",
        "init_0c", "init_0d", "init_0e", "init_0f",
        "porta_attr", "portb_attr",
        "clkamux", "enamux", "rstamux", "weamux",
        "clkbmux", "enbmux", "rstbmux", "webmux",
    ];
    
    let re = Regex::new(r#"defparam\s+(\S+)\.(\w+)\.CONF\s*=\s*"([^"]*)"\s*;"#)
        .map_err(|e| format!("regex error: {}", e))?;
    
    let duplicate_base_re = Regex::new(r#"(\d+'h)(\d+'h)"#)
        .map_err(|e| format!("regex error: {}", e))?;
    
    for line in reader.lines() {
        let line = line.map_err(|e| format!("failed to read line: {}", e))?;
        
        let line = duplicate_base_re.replace_all(&line, "${2}").to_string();
        
        let processed_line = if let Some(caps) = re.captures(&line) {
            let instance_path = &caps[1];
            let param_name = &caps[2];
            let value = &caps[3];
            
            let is_bram_instance = instance_path.contains("Bram") || instance_path.contains("bram");
            let is_bram_param = bram_params.contains(&param_name);
            
            if is_bram_instance && is_bram_param {
                if param_name.starts_with("init_") {
                    format!("defparam {}.{} = 256'h{};", instance_path, param_name, value)
                } else {
                    format!("defparam {}.{} = \"{}\";", instance_path, param_name, value)
                }
            } else {
                line
            }
        } else {
            line
        };
        
        writeln!(output_file, "{}", processed_line)
            .map_err(|e| format!("failed to write line: {}", e))?;
    }
    
    Ok(())
}

#[tauri::command]
pub async fn run_modelsim_simulation(args: SimulationArgs) -> Result<String, String> {
    let modelsim_work_dir = std::path::Path::new(&args.project_dir).join("modelsim");
    std::fs::create_dir_all(&modelsim_work_dir).map_err(|e| e.to_string())?;

    let do_content = "vcd file waveform.vcd\nvcd add -r /*\nrun -all\nquit -f\n";
    let do_path = modelsim_work_dir.join("sim_run.do");
    std::fs::write(&do_path, do_content).map_err(|e| e.to_string())?;

    let vlib = std::path::Path::new(&args.modelsim_dir).join("vlib");
    let vlog = std::path::Path::new(&args.modelsim_dir).join("vlog");
    let vsim = std::path::Path::new(&args.modelsim_dir).join("vsim");
    let vcd2wlf = std::path::Path::new(&args.modelsim_dir).join("vcd2wlf");

    let simlib_file = if args.netlist_path.ends_with("_gate.v") || args.netlist_path.ends_with("_map.v") {
        "MAPPING_SIMLIB.v"
    } else if args.netlist_path.ends_with("_pack.v") {
        "PACKING_SIMLIB_FDP3P7.v"
    } else if args.netlist_path.ends_with("_route.v") {
        "ROUTING_SIMLIB_FDP3P7.v"
    } else {
        ""
    };
    let simlib_path = if simlib_file.is_empty() {
        None
    } else {
        Some(std::path::Path::new(&args.edalib_dir).join(simlib_file))
    };

    let netlist_path = std::path::Path::new(&args.netlist_path);
    let processed_netlist_path = if args.netlist_path.ends_with("_map.v") 
        || args.netlist_path.ends_with("_pack.v") 
        || args.netlist_path.ends_with("_route.v") {
        let processed = modelsim_work_dir.join(format!(
            "{}_processed.v",
            netlist_path.file_stem().unwrap_or_default().to_string_lossy()
        ));
        preprocess_netlist(netlist_path, &processed)?;
        processed
    } else {
        netlist_path.to_path_buf()
    };

    let work_dir = modelsim_work_dir.join("work");
    if work_dir.exists() {
        std::fs::remove_dir_all(&work_dir).map_err(|e| format!("failed to remove old work directory: {}", e))?;
    }
    let output = std::process::Command::new(&vlib)
        .arg("work")
        .current_dir(&modelsim_work_dir)
        .output()
        .map_err(|e| format!("vlib failed: {}", e))?;
    if !output.status.success() {
        return Err(format!("vlib failed: {}", String::from_utf8_lossy(&output.stderr)));
    }

    let mut vlog_cmd = std::process::Command::new(&vlog);
    
    if let Some(ref p) = simlib_path {
        if p.exists() {
            vlog_cmd.arg(p);
        } else {
            return Err(format!("Simulation library not found: {}", p.display()));
        }
    }
    
    let default_custom_simlib = std::path::Path::new(&args.edalib_dir).join("custom_simlib.v");
    if default_custom_simlib.exists() {
        vlog_cmd.arg(&default_custom_simlib);
    } else {
        return Err(format!("custom_simlib.v not found at: {}", default_custom_simlib.display()));
    }
    
    if let Some(ref custom_path) = args.custom_simlib_path {
        if !custom_path.is_empty() 
            && std::path::Path::new(custom_path).exists() 
            && custom_path != default_custom_simlib.to_str().unwrap_or("") {
            vlog_cmd.arg(custom_path);
        }
    }
    
    vlog_cmd.arg(&processed_netlist_path);
    vlog_cmd.arg(&args.testbench_path);  
    vlog_cmd.current_dir(&modelsim_work_dir);
    
    let output = vlog_cmd.output()
        .map_err(|e| format!("vlog failed: {}", e))?;
    
    let vlog_stdout = String::from_utf8_lossy(&output.stdout);
    let vlog_stderr = String::from_utf8_lossy(&output.stderr);
    
    if !output.status.success() {
        return Err(format!(
            "vlog failed:\nstdout: {}\nstderr: {}", 
            vlog_stdout, 
            vlog_stderr
        ));
    }

    let output = std::process::Command::new(&vsim)
        .args(&["-c", "-novopt", &args.top_module, "-do", "sim_run.do"])
        .current_dir(&modelsim_work_dir)
        .output()
        .map_err(|e| format!("vsim failed: {}", e))?;
    
    let vsim_stdout = String::from_utf8_lossy(&output.stdout);
    let vsim_stderr = String::from_utf8_lossy(&output.stderr);
    
    if !output.status.success() {
        return Err(format!(
            "vsim failed:\nstdout: {}\nstderr: {}",
            vsim_stdout,
            vsim_stderr
        ));
    }

    let output = std::process::Command::new(&vcd2wlf)
        .args(&["waveform.vcd", "waveform.wlf"])
        .current_dir(&modelsim_work_dir)
        .output()
        .map_err(|e| format!("vcd2wlf failed: {}", e))?;
    if !output.status.success() {
        return Err(format!("vcd2wlf failed: {}", String::from_utf8_lossy(&output.stderr)));
    }

    std::process::Command::new(&vsim)
        .args(&["-view", "waveform.wlf"])
        .current_dir(&modelsim_work_dir)
        .spawn()
        .map_err(|e| format!("failed to open vsim viewer: {}", e))?;

    Ok("waveform.vcd / waveform.wlf".to_string())
}
