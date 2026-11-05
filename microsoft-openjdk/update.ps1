Import-Module chocolatey-au

function global:au_BeforeUpdate {
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}


# find and replace
function global:au_SearchReplace {
    @{
        'tools\chocolateyinstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {

   # Get the version number
   # Send another web request to the specified URL
   $response = Invoke-WebRequest -Uri "https://learn.microsoft.com/en-us/java/openjdk/download"
   # Check if the response content contains a test OpenJDK 25.x.x or 25.x.x.x
   if($response.content -match "OpenJDK 25\.\d+\.\d+(?:\.\d+)*") {
       # If it does, create a hashtable with the URL and version number
       $Version = ($Matches[0] -split " ")[1]
       # NuGet allows max 4 parts, so e.g. 25.0.5.0.2 becomes 25.0.5.2 for the package
       $parts = $Version -split '\.'
       $PackageVersion = if ($parts.Count -gt 4) { ($parts[0..2] + $parts[-1]) -join '.' } else { $Version }
   } else {
       # If it doesn't, return an empty hashtable
       return @{}
   }

   # Create a hashtable with the URL and version number of the latest update
   $Latest = @{ 
        URL64 = "https://aka.ms/download-jdk/microsoft-jdk-$version-windows-x64.msi"
        Version = $PackageVersion
   }
   # Return the hashtable
   Return $latest
}

update -ChecksumFor None -NoCheckChocoVersion