# Set ErrorActionPreference to Stop to make all errors terminating
$ErrorActionPreference = 'Stop'

# Get the repo URL and remove the '.git' at the end
$repoUrl = (Read-Host -Prompt 'Enter the repo URL ') -replace '.git$', ''

# Check if the user wants to use GitHub CLI or git
# Determine the clone command based on the arguments
$cloneCommand = if ($args -contains '-gh') { "gh repo clone $repoUrl" }
else { "git clone $repoUrl" }


# Get the folder name and replace invalid characters with underscores
$folderName = ($repoUrl -split '/' | Select-Object -Last 1)

# Define a function for cloning the repository
function Start-Clone {
    param($path)
    try {
        Set-Location -Path $path
        Invoke-Expression "$cloneCommand $folderName"
        Set-Location -Path "$path\$folderName"
    }
    catch {
        Write-Host "Git Error: $_" -ForegroundColor Red
        return
    }
}

try {
    # Check if the user wants to use the current directory
    if ($args -contains '.') {

        # Run the git clone command with its own try/catch block
        Invoke-Expression "$cloneCommand $folderName"
        Set-Location -Path "$folderName"
    }
    # Check if the user wants to change the path
    else {
        # read the path from the user and resolve it
        $customFolderName = (Read-Host -Prompt 'Enter the path ')
        mkdir $customFolderName
        $path = Resolve-Path -Path $customFolderName

        # Display the resolved path
        Write-Host "Cloning into '$path'..." -ForegroundColor DarkGreen

        # clone the repository
        Start-Clone $path
    }

    # Open in VS Code
    Invoke-Expression "code ."

}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
