$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'affine'
  fileType       = 'exe'
  url64bit       = ''
  checksum64     = ''
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
