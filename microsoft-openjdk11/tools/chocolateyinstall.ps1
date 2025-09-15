$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = ''
$checksum = ''

# allow for package parameters to override the default values for insallation directory.
$pp = Get-PackageParameters
if ($pp -and $pp['INSTALLDIR']) { 
  $installdir = $($pp['INSTALLDIR']) 
  $silentArgs = "INSTALLLEVEL=3 /quiet INSTALLDIR=`"$installdir`""
} else {
  $silentArgs = "INSTALLLEVEL=3 /quiet"
}             

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  Url64bit = $url
  Checksum64 = $checksum
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = $silentArgs
}
  
Install-ChocolateyPackage @packageArgs