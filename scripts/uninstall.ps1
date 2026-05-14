$ErrorActionPreference = "SilentlyContinue"

$registryPaths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenCMDHere",
    "HKCU:\Software\Classes\Directory\Background\shell\OpenCMDHere"
)

foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
    }
}

Write-Host ""
Write-Host "CMD context menu entries removed successfully." -ForegroundColor Green
Write-Host ""
