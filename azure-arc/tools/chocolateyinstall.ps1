$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = ''
$checksum = ''
$softwareName = 'Azure Arc Agent *1.30*'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi'
  url           = $url
  silentArgs    = "/quiet"
  validExitCodes= @(0, 3010, 1641)
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = $softwareName
}

Install-ChocolateyPackage @packageArgs