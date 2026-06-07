#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_TRIPLE="aarch64-apple-darwin"
BIN_DIR="$ROOT_DIR/src-tauri/binaries"
MACOS_BIN_DIR="$ROOT_DIR/src-tauri/macos-bin"
MACOS_LIB_DIR="$ROOT_DIR/src-tauri/macos-libs"
MACOS_PLUGIN_DIR="$ROOT_DIR/src-tauri/macos-plugins/platforms"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script builds macOS sidecars and must run on macOS." >&2
  exit 1
fi

mkdir -p "$BIN_DIR/ip-generator" "$BIN_DIR/fde-cli" \
  "$MACOS_BIN_DIR" "$MACOS_LIB_DIR" "$MACOS_PLUGIN_DIR"

cargo build \
  --manifest-path "$ROOT_DIR/src-tauri/ip-tools/Cargo.toml" \
  --release \
  --target "$TARGET_TRIPLE"

cp "$ROOT_DIR/src-tauri/ip-tools/target/$TARGET_TRIPLE/release/ip_generator" \
  "$BIN_DIR/ip-generator/ip_generator-$TARGET_TRIPLE"
cp "$ROOT_DIR/src-tauri/ip-tools/target/$TARGET_TRIPLE/release/img2mif" \
  "$BIN_DIR/ip-generator/img2mif-$TARGET_TRIPLE"
cp "$ROOT_DIR/src-tauri/ip-tools/target/$TARGET_TRIPLE/release/viewer" \
  "$BIN_DIR/fde-cli/viewer-$TARGET_TRIPLE"
chmod +x \
  "$BIN_DIR/ip-generator/ip_generator-$TARGET_TRIPLE" \
  "$BIN_DIR/ip-generator/img2mif-$TARGET_TRIPLE" \
  "$BIN_DIR/fde-cli/viewer-$TARGET_TRIPLE"

if [[ -x "$MACOS_BIN_DIR/fde-viewer" ]]; then
  echo "fde-viewer runtime binary already exists; skipping FDE viewer rebuild."
else
  FDE_SOURCE_DIR="${FDE_SOURCE_DIR:-$(cd "$ROOT_DIR/.." && pwd)/FDE-Source}"
  if [[ ! -d "$FDE_SOURCE_DIR" ]]; then
    echo "Missing FDE source tree: $FDE_SOURCE_DIR" >&2
    echo "Set FDE_SOURCE_DIR or provide $MACOS_BIN_DIR/fde-viewer." >&2
    exit 1
  fi

  QT5_PREFIX="${QT5_PREFIX:-/opt/homebrew/anaconda3}"
  BOOST_PREFIX="${BOOST_PREFIX:-/opt/homebrew/opt/boost}"
  VIEWER_BUILD_DIR="${VIEWER_BUILD_DIR:-$FDE_SOURCE_DIR/build-codex-macos-viewer}"

  cmake -S "$FDE_SOURCE_DIR" -B "$VIEWER_BUILD_DIR" -G Ninja \
    -DVIEWER=ON \
    -DQt5_DIR="$QT5_PREFIX/lib/cmake/Qt5" \
    -DCMAKE_PREFIX_PATH="$QT5_PREFIX;$BOOST_PREFIX" \
    -DBOOST_ROOT="$BOOST_PREFIX" \
    -DCMAKE_EXE_LINKER_FLAGS="-L$QT5_PREFIX/lib"

  cmake --build "$VIEWER_BUILD_DIR" --target FDE -j"$(sysctl -n hw.ncpu)"
  cp "$VIEWER_BUILD_DIR/viewer/FDE" "$MACOS_BIN_DIR/fde-viewer"
  chmod +x "$MACOS_BIN_DIR/fde-viewer"
fi

copy_lib() {
  local source="$1"
  if [[ ! -f "$source" ]]; then
    echo "Missing runtime library: $source" >&2
    exit 1
  fi
  cp -fL "$source" "$MACOS_LIB_DIR/$(basename "$source")"
  chmod 0644 "$MACOS_LIB_DIR/$(basename "$source")"
}

runtime_files=(
  "$MACOS_LIB_DIR/libQt5Core.5.dylib"
  "$MACOS_LIB_DIR/libQt5Gui.5.dylib"
  "$MACOS_LIB_DIR/libQt5Widgets.5.dylib"
  "$MACOS_LIB_DIR/libQt5DBus.5.dylib"
  "$MACOS_LIB_DIR/libQt5PrintSupport.5.dylib"
  "$MACOS_LIB_DIR/libicudata.73.dylib"
  "$MACOS_LIB_DIR/libicui18n.73.dylib"
  "$MACOS_LIB_DIR/libicuuc.73.dylib"
  "$MACOS_LIB_DIR/libpng16.16.dylib"
  "$MACOS_LIB_DIR/libz.1.dylib"
  "$MACOS_LIB_DIR/libzstd.1.dylib"
  "$MACOS_LIB_DIR/libboost_program_options.dylib"
  "$MACOS_LIB_DIR/libboost_thread.dylib"
  "$MACOS_LIB_DIR/libboost_filesystem.dylib"
  "$MACOS_LIB_DIR/libboost_chrono.dylib"
  "$MACOS_LIB_DIR/libboost_container.dylib"
  "$MACOS_LIB_DIR/libboost_date_time.dylib"
  "$MACOS_LIB_DIR/libboost_atomic.dylib"
  "$MACOS_PLUGIN_DIR/libqcocoa.dylib"
)

missing_runtime=0
for runtime_file in "${runtime_files[@]}"; do
  if [[ ! -f "$runtime_file" ]]; then
    missing_runtime=1
    break
  fi
done

QT5_PREFIX="${QT5_PREFIX:-/opt/homebrew/anaconda3}"
BOOST_PREFIX="${BOOST_PREFIX:-/opt/homebrew/opt/boost}"

if [[ "$missing_runtime" -eq 1 ]]; then
  copy_lib "$QT5_PREFIX/lib/libQt5Core.5.dylib"
  copy_lib "$QT5_PREFIX/lib/libQt5Gui.5.dylib"
  copy_lib "$QT5_PREFIX/lib/libQt5Widgets.5.dylib"
  copy_lib "$QT5_PREFIX/lib/libQt5DBus.5.dylib"
  copy_lib "$QT5_PREFIX/lib/libQt5PrintSupport.5.dylib"
  copy_lib "$QT5_PREFIX/lib/libicudata.73.dylib"
  copy_lib "$QT5_PREFIX/lib/libicui18n.73.dylib"
  copy_lib "$QT5_PREFIX/lib/libicuuc.73.dylib"
  copy_lib "$QT5_PREFIX/lib/libpng16.16.dylib"
  copy_lib "$QT5_PREFIX/lib/libz.1.dylib"
  copy_lib "$QT5_PREFIX/lib/libzstd.1.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_program_options.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_thread.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_filesystem.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_chrono.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_container.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_date_time.dylib"
  copy_lib "$BOOST_PREFIX/lib/libboost_atomic.dylib"

  cp -fL "$QT5_PREFIX/plugins/platforms/libqcocoa.dylib" \
    "$MACOS_PLUGIN_DIR/libqcocoa.dylib"
  chmod 0644 "$MACOS_PLUGIN_DIR/libqcocoa.dylib"
else
  echo "macOS viewer runtime libraries already exist; skipping runtime copy."
fi

install_name_tool -delete_rpath "$QT5_PREFIX/lib" "$MACOS_BIN_DIR/fde-viewer" 2>/dev/null || true
install_name_tool -add_rpath "@executable_path/../macos-libs" "$MACOS_BIN_DIR/fde-viewer" 2>/dev/null || true
install_name_tool -change "@rpath/libc++.1.dylib" "/usr/lib/libc++.1.dylib" "$MACOS_BIN_DIR/fde-viewer" 2>/dev/null || true

for lib in \
  libboost_program_options.dylib \
  libboost_thread.dylib \
  libboost_filesystem.dylib \
  libboost_chrono.dylib \
  libboost_container.dylib \
  libboost_date_time.dylib \
  libboost_atomic.dylib
do
  install_name_tool -change "$BOOST_PREFIX/lib/$lib" "@rpath/$lib" "$MACOS_BIN_DIR/fde-viewer" 2>/dev/null || true
done

for image in "$MACOS_LIB_DIR"/*.dylib; do
  install_name_tool -add_rpath "@loader_path" "$image" 2>/dev/null || true
  install_name_tool -change "@rpath/libc++.1.dylib" "/usr/lib/libc++.1.dylib" "$image" 2>/dev/null || true
done

install_name_tool -add_rpath "@loader_path/../../macos-libs" "$MACOS_PLUGIN_DIR/libqcocoa.dylib" 2>/dev/null || true
install_name_tool -change "@rpath/libc++.1.dylib" "/usr/lib/libc++.1.dylib" "$MACOS_PLUGIN_DIR/libqcocoa.dylib" 2>/dev/null || true
