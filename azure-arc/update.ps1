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
    $url = "https://learn.microsoft.com/en-us/azure/azure-arc/servers/agent-release-notes"
    # regex expresion to find version number example 1.38
    $regex = ([regex]"version\s(\d+\.\d+)")
    # sort numbers and get highest number
    $version = (((Invoke-WebRequest $url -UseBasicParsing).RawContent | Select-String "$regex" -AllMatches ).Matches.Value | Sort-Object -Descending -Unique)[0] -split " " | Select-Object -Last 1
 
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