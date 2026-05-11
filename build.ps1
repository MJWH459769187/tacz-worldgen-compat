param(
    [string]$JarExe = "",
    [string]$OutputPath = ""
)

$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
$sourcePath = Join-Path $root "src\main\resources"

if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $OutputPath = Join-Path $root "dist\zz_tacz_worldgen_compat-1.0.0.jar"
}

if ([string]::IsNullOrWhiteSpace($JarExe)) {
    $jarCommand = Get-Command jar.exe -ErrorAction SilentlyContinue
    if ($jarCommand) {
        $JarExe = $jarCommand.Source
    }
}

if ([string]::IsNullOrWhiteSpace($JarExe) -or -not (Test-Path -LiteralPath $JarExe)) {
    throw "jar.exe was not found. Pass -JarExe with a full path to jar.exe."
}

if (-not (Test-Path -LiteralPath $sourcePath)) {
    throw "Source path not found: $sourcePath"
}

$outputDir = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

if (Test-Path -LiteralPath $OutputPath) {
    Remove-Item -LiteralPath $OutputPath -Force
}

& $JarExe --create --file $OutputPath -C $sourcePath .

Write-Host "Built $OutputPath"
