$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'zed'
  fileType       = 'exe'
  url64bit       = ''
  checksum64     = ''
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
