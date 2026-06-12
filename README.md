# 网易云 NCM 解密器

`NetEase NCM Decryptor` 是一个极小体积的 Windows 本地 NCM 解密/转换工具。

作者：tuercha

## 功能

- 将网易云音乐 `.ncm` 文件转换为原始音频流。
- 双击运行，使用 Windows 原生文件选择框。
- 不依赖 .NET。
- 不依赖 VC++ 运行库。
- 不需要额外携带第三方 DLL。
- MP3 输出会尽量保留标题、艺人、专辑和内嵌封面。
- 重点目标是尽可能压缩可执行文件体积。

## 项目结构

```text
ncmmini.asm      MASM 汇编主源码
build.cmd        本地一键构建脚本
bcrypt_ord.def   bcrypt.dll 序号导入定义
hpack.ps1        PE 头部压缩脚本
```

构建产物会输出到：

```text
..\exe\NCM转换器.exe
```

## 构建要求

- Windows
- Microsoft Visual Studio 2022 Build Tools，并安装 MSVC x86 工具链
- PowerShell

构建方式：

```bat
build.cmd
```

## 运行要求

- Windows 7 或更高版本
- 支持运行 32 位 x86 程序
- 系统自带以下 DLL：
  - `kernel32.dll`
  - `user32.dll`
  - `comdlg32.dll`
  - `bcrypt.dll`

普通 Windows 10 / Windows 11 可以直接运行。Windows XP 不支持。

## 参考

本项目参考了 ncmdump 系列项目的 NCM 格式解析思路：

- taurusxin/ncmdump: https://github.com/taurusxin/ncmdump
- 原始 ncmdump 脉络：anonymous5l/ncmdump

本仓库不是直接 fork，而是一个面向极小体积的 MASM 重新实现版本。

## 说明

本项目为了压缩体积使用了比较激进的 PE 和链接优化，包括固定镜像基址、可写 `.text` 段、bcrypt 序号导入、合并 PE 段和 PE 头部压缩。
