$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$toolsDir = Join-Path $repoRoot ".tools"
$inklecateDir = Join-Path $toolsDir "inklecate_windows"
$inklecateExe = Join-Path $inklecateDir "inklecate.exe"
$releaseVersion = "v1.2.1"
$downloadUrl = "https://github.com/inkle/ink/releases/download/$releaseVersion/inklecate_windows.zip"
$zipPath = Join-Path $toolsDir "inklecate_windows.zip"
$inputFile = Join-Path $repoRoot "ink\bermuda_main.ink"
$outputFile = Join-Path $repoRoot "web\story.json"

if (-not (Test-Path $inputFile)) {
    throw "Ink source not found: $inputFile"
}

New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null

if (-not (Test-Path $inklecateExe)) {
    $ProgressPreference = "SilentlyContinue"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath

    if (Test-Path $inklecateDir) {
        Remove-Item -Recurse -Force $inklecateDir
    }

    Expand-Archive -Path $zipPath -DestinationPath $inklecateDir -Force
}

& $inklecateExe -o $outputFile $inputFile

Write-Host "Built $outputFile"
