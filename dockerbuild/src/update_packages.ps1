# set enviorment variables
$env:api        = ''
$env:github     = ''

# clone the repository
git clone https://github.com/HealisticEngineer/chocolatey-packages.git

# change directory to the cloned repository
Set-Location chocolatey-packages
# get-list of child directories
$directories = (Get-ChildItem -Directory).name

# loop through each directory and run ./update.ps1 command
foreach ($directory in $directories) {
    write-output "working from directory $directory"
    Set-Location $directory
    if(Test-Path ./update.ps1) {
        ./update.ps1
        # if file with .nupkg extension exists, push it to chocolatey
        $nupkg = (Get-Item *.nupkg).name
        if($nupkg) { choco push $nupkg -k $env:api -s https://push.chocolatey.org/ --allow-unofficial }
    }
    # at the end of the loop, go back to the parent directory
    Set-Location ..
}

# choco push self-hosted-integration-runtime.5.44.8993.1.nupkg -k 65c3c9ca-4c0c-45a9-9aa9-06cfead98442 -s https://push.chocolatey.org/ --allow-unofficial