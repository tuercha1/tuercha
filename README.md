# NetEase NCM Decryptor

Tiny local Windows NCM converter implemented in x86 MASM assembly.

Author: tuercha

## Features

- Converts NetEase Cloud Music `.ncm` files to the original audio stream.
- Double-click Windows GUI file picker.
- No .NET runtime.
- No VC++ runtime.
- No bundled third-party DLLs.
- Keeps MP3 title, artist, album, and embedded cover metadata when present.
- Optimized for extremely small executable size.

## Project Layout

```text
ncmmini.asm      Main MASM source
build.cmd        Local one-click build script
bcrypt_ord.def   bcrypt.dll ordinal import definition
hpack.ps1        PE header compaction step
```

The build output is written to:

```text
..\exe\NCM转换器.exe
```

## Build Requirements

- Windows
- Microsoft Visual Studio 2022 Build Tools with MSVC x86 tools
- PowerShell

Run:

```bat
build.cmd
```

## Runtime Requirements

- Windows 7 or later
- x86 program support
- System DLLs normally included with Windows:
  - `kernel32.dll`
  - `user32.dll`
  - `comdlg32.dll`
  - `bcrypt.dll`

Windows 10 and Windows 11 should run it directly. Windows XP is not supported.

## Reference

This project references the NCM parsing approach from the ncmdump lineage:

- taurusxin/ncmdump: https://github.com/taurusxin/ncmdump
- Original ncmdump lineage: anonymous5l/ncmdump

This repository is a minimal MASM reimplementation, not a direct fork.

## Notes

The executable uses aggressive size optimizations, including fixed image base,
writable text section, ordinal bcrypt imports, merged PE sections, and PE header
compaction.
