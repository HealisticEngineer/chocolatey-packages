Import-Module au

# find and replace
function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {

   # Get the version number
   # Send another web request to the specified URL
   $response = Invoke-WebRequest -Uri "https://learn.microsoft.com/en-us/java/openjdk/download"
   # Check if the response content contains a test OpenJDK 17.x.x
   if($response.content -match "OpenJDK 17\.\d+\.\d+") {
       # If it does, create a hashtable with the URL and version number
       $Version = ($Matches[0] -split " ")[1]
   } else {
       # If it doesn't, return an empty hashtable
       return @{}
   }

   # Create a hashtable with the URL and version number of the latest update
   $Latest = @{ 
        URL64 = "https://aka.ms/download-jdk/microsoft-jdk-17-windows-x64.msi"
        Version = $Version
   }
   # Return the hashtable
   Return $latest
}

update -ChecksumFor 64
