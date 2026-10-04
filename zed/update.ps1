import-module chocolatey-au

function global:au_SearchReplace {
  @{
    'tools\chocolateyinstall.ps1' = @{
      "(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_BeforeUpdate {
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_GetLatest {
  # /releases/latest excludes prereleases and drafts; guard anyway.
  $release = Invoke-RestMethod 'https://api.github.com/repos/zed-industries/zed/releases/latest'
  if ($release.prerelease -or $release.draft) { throw "Latest release $($release.tag_name) is not a stable release" }
  $version = $release.tag_name -replace '^v', ''
  $asset   = $release.assets | Where-Object { $_.name -eq 'Zed-x86_64.exe' }

  return @{
    URL64   = $asset.browser_download_url
    Version = $version
  }
}

update -ChecksumFor None -NoCheckChocoVersion
