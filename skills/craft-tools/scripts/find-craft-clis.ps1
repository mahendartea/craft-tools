# Print the path of each ArtCraft app CLI on Windows, or "missing".
# Reads the filesystem only: no network, no writes.
$ErrorActionPreference = "SilentlyContinue"
$script:missing = $false

Write-Output "platform=Windows"

function Find-CraftCli {
    param(
        [string]$Name,
        [string]$Exe,
        [string]$EnvName
    )

    $override = [Environment]::GetEnvironmentVariable($EnvName)
    if ($override -and (Test-Path -LiteralPath $override)) {
        Write-Output "$Name=$override"
        return
    }

    $cmd = Get-Command $Exe -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($cmd) {
        Write-Output "$Name=$($cmd.Source)"
        return
    }

    $roots = @()
    if ($env:LOCALAPPDATA) { $roots += (Join-Path $env:LOCALAPPDATA "Programs\ArtCraft") }
    if ($env:ProgramFiles) { $roots += (Join-Path $env:ProgramFiles "ArtCraft") }
    if (${env:ProgramFiles(x86)}) { $roots += (Join-Path ${env:ProgramFiles(x86)} "ArtCraft") }

    foreach ($root in $roots) {
        if (-not (Test-Path -LiteralPath $root)) { continue }
        $found = Get-ChildItem -LiteralPath $root -Filter $Exe -Recurse -ErrorAction SilentlyContinue |
            Select-Object -First 1
        if ($found) {
            Write-Output "$Name=$($found.FullName)"
            return
        }
    }

    Write-Output "$Name=missing"
    $script:missing = $true
}

Find-CraftCli "figcraft" "figcraft-cli.exe" "FIGCRAFT_CLI"
Find-CraftCli "filmcraft" "filmcraft-cli.exe" "FILMCRAFT_CLI"
Find-CraftCli "anicraft" "anicraft-cli.exe" "ANICRAFT_CLI"
Find-CraftCli "effectcraft" "effectcraft-cli.exe" "EFFECTCRAFT_CLI"
Find-CraftCli "vectorcraft" "vectorcraft-cli.exe" "VECTORCRAFT_CLI"

if ($script:missing) {
    Write-Output "note=Install the missing ArtCraft app, or set the matching *_CLI environment variable."
    Write-Output "note=Portable builds keep <app>-cli.exe next to the app; add that folder to PATH."
    exit 1
}

exit 0
