$ErrorActionPreference = 'Stop'

# Counterpart to the explicit Install-BinFile call in chocolateyInstall.ps1 -
# Chocolatey does not automatically clean up shims created that way.
Uninstall-BinFile -Name 'tursodb'
