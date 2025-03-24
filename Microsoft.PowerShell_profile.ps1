Function Artisan {
    Invoke-Expression "php artisan $args"
}

Function CreateNewFile {
    param (
        [string]$Path
    )
    Invoke-Expression "New-Item -ItemType File -Path $Path"
}

function VimConfig {
    $nvimPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim"
    Invoke-Expression "nvim '$nvimPath'"
}


$env:Path += ";$HOME\Scripts"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

New-Alias -Name art -Value Artisan
New-Alias -Name touch -Value CreateNewFile
New-Alias -Name vim -Value nvim
New-Alias -Name vimconfig -Value VimConfig


