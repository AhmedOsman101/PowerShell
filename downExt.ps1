# Parse the extensions.json file to get the list of extensions
$extensions = (Get-Content -Path .\extensions.json | ConvertFrom-Json)

if (-not (Test-Path ".\extensions")) {
  mkdir ".\extensions"
}

# Loop through each extension and download the .vsix file
foreach ($extension in $extensions) {
  # Construct the download URL
  $publisher = $extension.Split('.')[0]
  $extensionName = $extension.Split('.')[1]
  $url = "https://$publisher.gallery.vsassets.io/_apis/public/gallery/publisher/$publisher/extension/$extensionName/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"

  # Construct the filename for the .vsix file
  $filename = "$extensionName.vsix"

  # Check if the file already exists in the directory
  if (Test-Path "extensions\$filename") {
    Write-Host "Skipping $filename. File already exists."
  }
  else {
    # Download the .vsix file
    try {
      Invoke-WebRequest -Uri $url -OutFile ".\extensions\$filename"
      Write-Host "Downloaded $filename"
    }
    catch {
      Write-Host "Failed to download $filename"
    }
  }
}
