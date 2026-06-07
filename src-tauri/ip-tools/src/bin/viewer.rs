use std::env;
use std::path::PathBuf;
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

    let resources = env::var_os("UFDE_RESOURCES_DIR")
        .map(PathBuf::from)
        .unwrap_or_else(|| {
            exe.parent()
                .and_then(|macos_dir| macos_dir.parent())
                .map(|contents_dir| contents_dir.join("Resources"))
                .unwrap_or_else(|| PathBuf::from("../Resources"))
        });

    let viewer = env::var_os("UFDE_VIEWER_BIN")
        .map(PathBuf::from)
        .unwrap_or_else(|| resources.join("macos-bin/fde-viewer"));

    let mut command = Command::new(&viewer);
    command.args(env::args_os().skip(1));
    command.env("QT_PLUGIN_PATH", resources.join("macos-plugins"));
    command.env(
        "QT_QPA_PLATFORM_PLUGIN_PATH",
        resources.join("macos-plugins/platforms"),
    );
    command.env(
        "DYLD_FALLBACK_LIBRARY_PATH",
        resources.join("macos-libs"),
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
