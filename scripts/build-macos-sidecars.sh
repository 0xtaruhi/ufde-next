#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT_DIR/scripts/prepare-tauri-sidecars.sh" \
  --target aarch64-apple-darwin \
  --platform macos
