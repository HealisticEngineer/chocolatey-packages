# clone the repository
git clone https://github.com/HealisticEngineer/chocolatey-packages.git

# change directory to the cloned repository
Set-Location chocolatey-packages
# get-list of child directories
$directories = (Get-ChildItem -Directory).name

# returns the reason to skip a package, or $null when it is safe to update
function Get-ChocolateySkipReason {
    param([string]$PackageId)

    try {
        $page = (Invoke-WebRequest -Uri "https://community.chocolatey.org/packages/$PackageId" -UseBasicParsing).Content
    }
    catch {
        # a 404 means the package is new, so there is no pending version to wait for
        if ($_.Exception.Response.StatusCode.value__ -eq 404) { return $null }
        return 'could not check Chocolatey status'
    }

    # the first row of the version history is the latest submitted version, which may still be awaiting approval
    $row     = [regex]::Match($page, '(?s)<tr class="align-middle[^"]*">.*?</tr>').Value
    $version = [regex]::Match($row, '<span>([^<]+)</span>\s*</(?:a|td)>').Groups[1].Value
    $status  = [regex]::Match($row, '</span>\s*([A-Za-z ]+?)\s*</td>\s*</tr>').Groups[1].Value

    if ($status -and $status -notin 'Approved', 'Rejected', 'Exempted') {
        return "version $version is '$status' on Chocolatey"
    }
    return $null
}

# loop through each directory and run ./update.ps1 command
foreach ($directory in $directories) {
    Write-Output "working from directory $directory"
    Set-Location $directory

    $skipReason = $null
    $nuspec = Get-ChildItem -Filter *.nuspec | Select-Object -First 1
    if ($nuspec) {
        $packageId  = ([xml](Get-Content $nuspec.FullName)).package.metadata.id
        $skipReason = Get-ChocolateySkipReason -PackageId $packageId
    }

    if ($skipReason) {
        Write-Output "Skipping $directory - $skipReason"
    }
    elseif (Test-Path ./update.ps1) {
        ./update.ps1
        # if file with .nupkg extension exists, push it to chocolatey
        $nupkg = (Get-Item *.nupkg).name
        if ($nupkg) { choco push $nupkg -k $env:CHOCO_API_KEY -s https://push.chocolatey.org/ --allow-unofficial }
    }

    # at the end of the loop, go back to the parent directory
    Set-Location ..
}
