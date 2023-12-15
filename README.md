<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="./src-tauri/icons/128x128@2x.png" alt="UFDE+ Logo"></a>
</p>

<h3 align="center">UFDE+</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/0xtaruhi/ufde-next.svg)](https://github.com/0xtaruhi/ufde-next/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/0xtaruhi/ufde-next.svg)](https://github.com/0xtaruhi/ufde-next/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> UFDE+ is a new generation of FPGA integrated design environment from synthesis to implementation for Fudan University's self-developed FPGAs.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Authors](#authors)

## 🧐 About <a name = "about"></a>

UFDE+ is a new generation of FPGA integrated design environment from synthesis to implementation for Fudan University's self-developed FPGAs. It is designed to be a complete and easy-to-use FPGA design environment. UFDE+ is a cross-platform application based on the Tauri framework, which can run on Windows, Linux and macOS.

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

#### Rust & Cargo

Install [Rust](https://www.rust-lang.org/tools/install) and [Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html) first. Recommended installation method is via [rustup](https://rustup.rs/).

#### pnpm

Install [pnpm](https://pnpm.io/installation) first. Optionally, you can use npm or yarn instead.

#### Cmake

Install [Cmake](https://cmake.org/install/)

#### Clang

We recommend using [Clang](https://clang.llvm.org/) as the C/C++ compiler on the Linux and macOS platforms. On Windows, you can use [MSVC](https://visualstudio.microsoft.com/zh-hans/vs/features/cplusplus/)(*tested*) or [MinGW](http://www.mingw.org/) instead.

### Installing

#### Clone the repository

```
git clone https://github.com/0xtaruhi/ufde-next.git
```

#### Build FDE CLI

The FDE Command Line Interface (FDE CLI) is a command line tool for FPGA design. It is written in C++ and it is the core of UFDE+. Although I've
tried to clean all the warnings, there may still be some warnings when compiling. Just ignore them.

FDE CLI is a submodule of UFDE+. So you need to initialize the submodule first:

```bash
git submodule update --init --recursive
```

Then, run the following command to build FDE CLI:

```bash
cd public/FDE-Source
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . && cmake --install .
```

You can find the built FDE CLI in the `public/FDE-Source/build/bin` directory. 

**Note:** 
1. If you are using MSVC on Windows, you need to add the `--config Release` option to the `cmake --build .` command.
2. On macOS, the error `ld: library 'icudata' not found` may occur when building FDE CLI. You can fix this by running the following command: (Surely you need to install this library via Homebrew)
```bash
export LIBRARY_PATH=${LIBRARY_PATH}:/usr/local/opt/icu4c/lib
```
3. **IMPORTANT**: **DO NOT CHANGE THE BUILD DIRECTORY NAME!**

#### Build UFDE+

Change the current directory to the root directory of UFDE+ and run the following command to install the dependencies:

```bash
pnpm install
```

Then, run the following command to start the application:

```bash
pnpm tauri dev
```

This will start the application in development mode. You can also build the application by running the following command:

```bash
pnpm tauri build
```

This will build the application for your current platform. You can find the built application in the `src-tauri/target/release` directory.

## ✍️ Authors <a name = "authors"></a>

- [@0xtaruhi](https://github.com/0xtaruhi) - Initial work