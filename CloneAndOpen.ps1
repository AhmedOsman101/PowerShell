# Ask the user for the programming language of the repo
$lang = Read-Host -Prompt 'Enter a language '

# Ask the user for the first command
$cloneCommand = Read-Host -Prompt 'Enter the clone command '

# Split the first command into parts
$parts = $cloneCommand -split ' '

# Check if the first word of the command is 'gh' or 'git'
if ($parts[0] -eq 'gh') {
    # Get the repo URL
    $repoUrl = $parts[-1]
}
elseif ($parts[0] -eq 'git') {
    # Get the repo URL and remove '.git' at the end
    $repoUrl = $parts[-1]
    $repoUrl = $repoUrl -replace '.git$', ''
}
else {
    Write-Host "Invalid command. Please enter a 'gh' or 'git' command."
    return
}

# Get the folder name and replace invalid characters with underscores
$folderName = $repoUrl -split '/' | Select-Object -Last 1
$folderName = $folderName -replace '[^a-zA-Z0-9]', '_'

if ($lang -eq 'php') {
    $path = "F:\Apps\xampp\htdocs"
    # print out the website url
    Write-Output "http://localhost/$folderName/"
}
else {
    # Check if they need to change the path
    $response = Read-Host -Prompt 'Do you want to change the path? (y/n) '
    if ($response -eq 'y' -or $response -eq 'Y') {
        # Ask the user for the path
        $path = Read-Host -Prompt 'Enter the path '
    }
    elseif ($response -eq 'n' -or $response -eq 'N') {
        $path = "F:\books and assignments\IT\3rd year"
    }
    else {
        Write-Host "Invalid response. Please enter 'y' or 'n'."
        return
    }
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
