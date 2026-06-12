# 网易云 NCM 解密器

一个很小的 Windows 本地 `.ncm` 转换工具。

用 x86 MASM 写的。
主要目标就是小，能用，然后别带一堆运行库。

## 用法

双击 `NCM转换器.exe`。

选一个 `.ncm` 文件。

转换后的音频会出现在原文件旁边。

如果转出来是 MP3，会尽量把标题、艺人、专辑、封面也带上。

## 里面有什么

```text
ncmmini.asm      主体
build.cmd        构建脚本
bcrypt_ord.def   bcrypt 序号导入
hpack.ps1        PE 头压缩
```

运行：

```bat
build.cmd
```

产物在：

```text
..\exe\NCM转换器.exe
```

## 构建要什么

- Windows
- Visual Studio 2022 Build Tools
- MSVC x86 工具链
- PowerShell

没有这些就别硬编了，会很痛苦。

## 运行要什么

- Windows 7 及以上
- 能跑 32 位程序
- 系统里有这些 DLL：
  - `kernel32.dll`
  - `user32.dll`
  - `comdlg32.dll`
  - `bcrypt.dll`

Windows 10 / 11 一般直接能跑。

XP 就算了，太古早。

## 参考

NCM 结构解析参考了 ncmdump 这一系：

- https://github.com/taurusxin/ncmdump
- anonymous5l/ncmdump

不是 fork。

这边是重新写的极小 MASM 版。

## 体积

为了压体积，做了不少比较激进的东西：

- 固定镜像基址
- 可写 `.text` 段
- bcrypt 序号导入
- 合并 PE 段
- PE 头部压缩

所以它不是那种标准模板工程。

更像是能跑就往小里怼的版本。
