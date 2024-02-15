# Get the repo URL
$repoUrl = Read-Host -Prompt 'Enter the repo URL '

# remove the '.git' at the end
$repoUrl = $repoUrl -replace '.git$', ''

# Ask the user for the git command
$cloneCommand = "git clone $repoUrl"

# Get the folder name and replace invalid characters with underscores
$folderName = $repoUrl -split '/' | Select-Object -Last 1
$folderName = $folderName -replace '[^a-zA-Z0-9]', '_'

if ($args -contains '-php') {
    # path to XAMPP
    $path = "F:\Apps\xampp\htdocs"
    # print out the website url
    Write-Output "http://localhost/$folderName/"
}
# Check if the user wants to use the current directory
elseif ($args -contains '.') {
    # Using Get-Location cmdlet
    $workingDirectory = Get-Location
    $path = "$workingDirectory\$folderName"
}
# Check if the user wants to change the path
else {
    # Check if they need to change the path
    $path = Read-Host -Prompt 'Enter the path '
}

# Change directory to htdocs
Set-Location -Path $path

# Run the first command
Invoke-Expression "$cloneCommand $folderName"

# Change directory
Set-Location -Path "$path\$folderName"

# Open in VS Code
Invoke-Expression "code ."

# Go back to the parent directory
Set-Location -Path $path

