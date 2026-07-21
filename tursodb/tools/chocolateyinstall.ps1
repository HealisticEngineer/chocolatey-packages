$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageName  = 'tursodb'
$url          = 'https://github.com/tursodatabase/turso/releases/download/v0.7.0/turso_cli-x86_64-pc-windows-msvc.zip'
$checksum     = '0B6753714805623AFCCE5715D1B6A0000F952A6246D74ECBA05425BCE0539052'
$checksumType = 'sha256'

# Allow overriding where tursodb.exe gets extracted to, e.g.:
#   choco install tursodb --params "'/InstallDir:C:\tools\tursodb'"
# Defaults to this package's own tools folder when not specified.
$pp = Get-PackageParameters
$installDir = if ($pp['InstallDir']) { $pp['InstallDir'] } else { $toolsDir }

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $installDir
  url64bit       = $url
  checksum64     = $checksum
  checksumType64 = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

# Always shim explicitly (instead of relying on Chocolatey's automatic shimming
# of exes found in the package's own tools folder) so behavior - and the shim's
# target path - is identical whether InstallDir is the default location or a
# custom one.
New-Item -ItemType File -Path (Join-Path $toolsDir 'tursodb.exe.ignore') -Force | Out-Null
Install-BinFile -Name 'tursodb' -Path (Join-Path $installDir 'tursodb.exe')
