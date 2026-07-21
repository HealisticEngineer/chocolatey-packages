import-module chocolatey-au

function global:au_SearchReplace {
  @{
    'tools\chocolateyinstall.ps1' = @{
      "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
      "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_GetLatest {
  # Track only stable (non-prerelease) releases; tursodatabase/turso intersperses
  # prereleases (e.g. 0.8.0-pre.1) with stable tags (e.g. 0.7.0), and /releases/latest
  # correctly excludes prereleases.
  $release = Invoke-RestMethod 'https://api.github.com/repos/tursodatabase/turso/releases/latest'
  $version = $release.tag_name -replace '^v', ''
  $asset   = $release.assets | Where-Object { $_.name -eq 'turso_cli-x86_64-pc-windows-msvc.zip' }

  return @{
    URL64   = $asset.browser_download_url
    Version = $version
  }
}

update -ChecksumFor None -NoCheckChocoVersion
