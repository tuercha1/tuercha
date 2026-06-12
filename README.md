# 网易云 NCM 解密器

一个很小的 Windows 本地 NCM 转换工具，主要用来把网易云音乐的 `.ncm` 文件转成原始音频。

这个版本用 x86 MASM 汇编写，目标就是尽量小。最终 exe 只有几 KB，不需要 .NET，不需要 VC++ 运行库，也不用额外带 DLL。

## 怎么用

双击 `NCM转换器.exe`，选一个 `.ncm` 文件，转换后的音频会输出到同目录。

MP3 会尽量带上标题、艺人、专辑和封面。

## 源码里有什么

```text
ncmmini.asm      主源码
build.cmd        一键构建
bcrypt_ord.def   bcrypt 序号导入
hpack.ps1        PE 头部压缩
```

运行 `build.cmd` 后，产物会输出到：

```text
..\exe\NCM转换器.exe
```

## 构建需要

- Windows
- Visual Studio 2022 Build Tools
- MSVC x86 工具链
- PowerShell

## 运行需要

- Windows 7 或更高版本
- 能运行 32 位程序
- 系统自带 `kernel32.dll`、`user32.dll`、`comdlg32.dll`、`bcrypt.dll`

Windows 10 / 11 正常可以直接运行。Windows XP 不支持。

## 参考

NCM 格式解析思路参考了 ncmdump 系列：

- https://github.com/taurusxin/ncmdump
- anonymous5l/ncmdump

这个仓库不是直接 fork，是重新做的极小体积 MASM 版本。

## 说明

为了压体积，这个版本用了比较激进的 PE 优化，比如固定镜像基址、可写 `.text` 段、bcrypt 序号导入、合并 PE 段和 PE 头部压缩。
