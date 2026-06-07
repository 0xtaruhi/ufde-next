use std::env;
use std::path::{Path, PathBuf};
use std::process::Command;

#[cfg(unix)]
use std::os::unix::process::CommandExt;

fn main() {
    let exe = match env::current_exe() {
        Ok(path) => path,
        Err(error) => {
            eprintln!("failed to resolve viewer wrapper path: {error}");
            std::process::exit(1);
        }
    };

    let resources = resolve_resources_dir(&exe);
    let viewer = env::var_os("UFDE_VIEWER_BIN")
        .map(PathBuf::from)
        .or_else(|| find_viewer(&exe, &resources))
        .unwrap_or_else(|| {
            eprintln!(
                "FDE viewer runtime is not bundled for this platform. \
Set UFDE_VIEWER_BIN to a viewer executable."
            );
            std::process::exit(1);
        });

    let mut command = Command::new(&viewer);
    command.args(env::args_os().skip(1));
    command.env("QT_PLUGIN_PATH", resources.join(plugin_dir_name()));
    command.env(
        "QT_QPA_PLATFORM_PLUGIN_PATH",
        resources.join(plugin_dir_name()).join("platforms"),
    );
    command.env("LD_LIBRARY_PATH", resources.join(lib_dir_name()));
    command.env(
        "DYLD_FALLBACK_LIBRARY_PATH",
        resources.join(lib_dir_name()),
    );

    #[cfg(unix)]
    {
        let error = command.exec();
        eprintln!("failed to launch {}: {error}", viewer.display());
        std::process::exit(1);
    }

    #[cfg(not(unix))]
    {
        match command.status() {
            Ok(status) => std::process::exit(status.code().unwrap_or(1)),
            Err(error) => {
                eprintln!("failed to launch {}: {error}", viewer.display());
                std::process::exit(1);
            }
        }
    }
}

fn resolve_resources_dir(exe: &Path) -> PathBuf {
    if let Some(path) = env::var_os("UFDE_RESOURCES_DIR") {
        return PathBuf::from(path);
    }

    let Some(exe_dir) = exe.parent() else {
        return PathBuf::from("../Resources");
    };

    let candidates = [
        exe_dir
            .parent()
            .map(|contents_dir| contents_dir.join("Resources")),
        Some(exe_dir.join("../Resources")),
        Some(exe_dir.join("resources")),
        Some(exe_dir.to_path_buf()),
    ];

    candidates
        .into_iter()
        .flatten()
        .find(|path| path.exists())
        .unwrap_or_else(|| exe_dir.join("../Resources"))
}

fn find_viewer(exe: &Path, resources: &Path) -> Option<PathBuf> {
    let exe_dir = exe.parent();
    let candidates = [
        resources.join(bin_dir_name()).join(viewer_file_name()),
        resources.join(viewer_file_name()),
        exe_dir
            .map(|dir| dir.join(format!("fde-viewer{}", env::consts::EXE_SUFFIX)))
            .unwrap_or_default(),
    ];

    candidates.into_iter().find(|path| path.exists())
}

fn bin_dir_name() -> &'static str {
    match env::consts::OS {
        "macos" => "macos-bin",
        "linux" => "linux-bin",
        "windows" => "windows-bin",
        _ => "bin",
    }
}

fn lib_dir_name() -> &'static str {
    match env::consts::OS {
        "macos" => "macos-libs",
        _ => "libs",
    }
}

fn plugin_dir_name() -> &'static str {
    match env::consts::OS {
        "macos" => "macos-plugins",
        _ => "plugins",
    }
}

fn viewer_file_name() -> &'static str {
    if cfg!(windows) {
        "fde-viewer.exe"
    } else {
        "fde-viewer"
    }
}
