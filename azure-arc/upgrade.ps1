import-module au

function global:au_SearchReplace {
    @{
        #   softwareName  = 'Azure Arc Agent *1.30*'
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]softwareName\s*=\s*)('.*')" = "`$1'Azure Arc Agent *$($Latest.version)*'"

        }
     }

}
 
function global:au_GetLatest {

    # download the page that contains the latest version number
    $url = https://learn.microsoft.com/en-us/azure/azure-arc/servers/agent-release-notes
    # regex expresion to find version number example 1.38
    $regex = ([regex]"version\s(\d+\.\d+)")
    # sort numbers and get highest number
    $version = (((iwr $url -UseBasicParsing).RawContent | Select-String "$regex" -AllMatches ).Matches.Value | Sort-Object -Descending -Unique)[0] -split " " | Select-Object -Last 1
 

    # construct the download url for the latest version
    $URL64 = https://download.microsoft.com/download/e/a/7/ea70743f-0b72-4607-908b-5015fa6c052d/AzureConnectedMachineAgent.msi
    # construct the checksum for the latest version
    $Latest = @{
        URL64 = $URL64
        Version = $version
    }
    # return the latest version
    return $Latest
}

update -ChecksumFor 64