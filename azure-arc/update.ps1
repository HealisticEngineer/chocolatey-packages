Import-Module chocolatey-au

function global:au_BeforeUpdate {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyinstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}
 
function global:au_GetLatest {

    # download the page that contains the latest version number
    $url = "https://docs.azure.cn/en-us/azure-arc/servers/agent-release-notes"
    # regex expresion to find version number example 1.38
    # only match release headings; body text can mention unreleased versions
    $regex = '<h2[^>]*>\s*Version\s+(1\.\d+(?:\.\d+)*)'
    # sort numerically as [version] (string sort would rank 1.9 above 1.69) and get highest
    $content = (Invoke-WebRequest $url -UseBasicParsing).RawContent
    $version = [regex]::Matches($content, $regex) | ForEach-Object { [version]$_.Groups[1].Value } | Sort-Object -Descending -Unique | Select-Object -First 1
    $version = $version.ToString()
 
    $URL64 = "https://gbl.his.arc.azure.com/azcmagent/$version/AzureConnectedMachineAgent.msi"


    # construct the checksum for the latest version
    $Latest = @{
        URL64 = $URL64
        Version = $version
    }
    # return the latest version
    return $Latest
}

update -ChecksumFor None -NoCheckChocoVersion