param([string]$In,[string]$Out)
$ErrorActionPreference = 'Stop'
$b = [IO.File]::ReadAllBytes($In)
function U16($o){ [BitConverter]::ToUInt16($b,$o) }
function U32($o){ [BitConverter]::ToUInt32($b,$o) }
function W32($o,[uint32]$v){ $x=[BitConverter]::GetBytes($v); [Array]::Copy($x,0,$b,$o,4) }
$cnName = -join ([char[]](0x004e,0x0043,0x004d,0x8f6c,0x6362,0x5668,0x002e,0x0065,0x0078,0x0065))
$cn = Join-Path (Split-Path -Path $Out -Parent) $cnName
$oldPe = U32 0x3c
if($oldPe -ne 216){
  [IO.File]::WriteAllBytes($Out,$b)
  [IO.File]::WriteAllBytes($cn,$b)
  exit 0
}
$coff = $oldPe + 4
$n = U16 ($coff + 2)
$opt = U16 ($coff + 16)
$oh = $coff + 20
$sec = $oh + $opt
$end = $sec + $n * 40
if($n -ne 2 -or $opt -ne 224 -or $end -ne 544){
  [IO.File]::WriteAllBytes($Out,$b)
  [IO.File]::WriteAllBytes($cn,$b)
  exit 0
}
W32 0x3c 184
W32 ($oh + 60) 512
W32 ($oh + 96 + 6 * 8) 0
W32 ($oh + 96 + 6 * 8 + 4) 0
for($i=0;$i -lt $n;$i++){
  $off = $sec + $i * 40
  $ptr = U32 ($off + 20)
  if($ptr -ge 1024){ W32 ($off + 20) ($ptr - 512) }
}
$header = New-Object byte[] 512
[Array]::Copy($b,0,$header,0,184)
[Array]::Copy($b,216,$header,184,328)
$outBytes = New-Object byte[] ($header.Length + $b.Length - 1024)
[Array]::Copy($header,0,$outBytes,0,$header.Length)
[Array]::Copy($b,1024,$outBytes,512,$b.Length-1024)
[IO.File]::WriteAllBytes($Out,$outBytes)
[IO.File]::WriteAllBytes($cn,$outBytes)
