$ErrorActionPreference = 'Stop'

$keys = Get-UninstallRegistryKey -SoftwareName 'Zed*'

if ($keys.Count -eq 1) {
  $file = ($keys[0].UninstallString -replace '^"?([^"]+\.exe)"?.*$', '$1')
  Uninstall-ChocolateyPackage -PackageName 'zed' -FileType 'exe' -SilentArgs '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART' -File $file -ValidExitCodes @(0)
}
elseif ($keys.Count -eq 0) {
  Write-Warning 'Zed was not found in installed programs; nothing to uninstall.'
}
else {
  Write-Warning "$($keys.Count) matches found; refusing to uninstall automatically."
  $keys | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
