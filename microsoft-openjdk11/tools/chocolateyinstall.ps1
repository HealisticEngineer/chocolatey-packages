$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = ''
$checksum = ''

$packageArgs = @{
    PackageName = $env:ChocolateyPackageName
    Url64bit = $url
    Checksum64 = $checksum
    ChecksumType64 = 'sha256'
    fileType      = 'msi'
    silentArgs    = "INSTALLLEVEL=3 /quiet"
  }
  
Install-ChocolateyPackage @packageArgs
