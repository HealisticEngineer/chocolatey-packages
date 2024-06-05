$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = ''
$checksum = ''

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'msi'
    Url64bit = $url
    silentArgs    = "/quiet"
    validExitCodes= @(0, 3010, 1641)
    Checksum64 = $checksum
    ChecksumType64 = 'sha256'
  }

Install-ChocolateyPackage @packageArgs