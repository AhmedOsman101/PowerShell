# Get all VS Code extensions
$extensions = & code --list-extensions

# Format the extensions for the JSON file
$extensionsFormatted = $extensions -join '","'

# Create the JSON content
$jsonContent = @"
{
  "recommendations": [
    "$extensionsFormatted"
  ]
}
"@

# Check if the file already exists
if (Test-Path -Path extensions.json) {
  if ($args -contains '-o') {
    # Overwrite the file
    $jsonContent | Out-File -FilePath extensions.json
    Write-Host "The file extensions.json has been overwritten."
  }
  elseif (-not $args -contains '-o') {
    # Ask the user if they want to overwrite the existing file
    $overwrite = Read-Host -Prompt 'The file extensions.json already exists. Do you want to overwrite it? (Y/N)'

    # Check the user's response
    if ($overwrite -eq 'Y' -or $overwrite -eq 'y') {
      # Overwrite the file
      $jsonContent | Out-File -FilePath extensions.json
      Write-Host "extensions.json has been overwritten."
    }
    else {
      Write-Host "original file was not overwritten."
    }
  }
}
else {
  # Write the JSON content to the file
  $jsonContent | Out-File -FilePath extensions.json
  Write-Host "The file extensions.json has been created."
}
