$ErrorActionPreference = 'Stop'

$keys = Get-UninstallRegistryKey -SoftwareName 'AnythingLLM*'

if ($keys.Count -eq 1) {
  $key = $keys[0]
  $file = ($key.UninstallString -replace '^"?([^"]+\.exe)"?.*$', '$1')
  Uninstall-ChocolateyPackage -PackageName 'anythingllm' -FileType 'exe' -SilentArgs '/S' -File $file -ValidExitCodes @(0)
}
elseif ($keys.Count -eq 0) {
  Write-Warning 'AnythingLLM was not found in installed programs; nothing to uninstall.'
}
else {
  Write-Warning "$($keys.Count) matches found; refusing to uninstall automatically."
  $keys | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
