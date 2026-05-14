$ErrorActionPreference = "Stop"

function Get-CmdPath {
    if ($env:ComSpec -and (Test-Path $env:ComSpec)) {
        return $env:ComSpec
    }

    $fallbackPath = Join-Path $env:SystemRoot "System32\cmd.exe"

    if (Test-Path $fallbackPath) {
        return $fallbackPath
    }

    return $null
}

function Set-RegistryDefaultValue {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    New-Item -Path $Path -Force | Out-Null
    Set-Item -Path $Path -Value $Value
}

function Add-CmdContextMenuEntry {
    param (
        [Parameter(Mandatory = $true)]
        [string]$RegistryPath,

        [Parameter(Mandatory = $true)]
        [string]$TargetPlaceholder,

        [Parameter(Mandatory = $true)]
        [string]$CmdPath
    )

    $commandPath = Join-Path $RegistryPath "command"

    New-Item -Path $RegistryPath -Force | Out-Null
    New-Item -Path $commandPath -Force | Out-Null

    Set-RegistryDefaultValue -Path $RegistryPath -Value "Open CMD here"

    New-ItemProperty `
        -Path $RegistryPath `
        -Name "MUIVerb" `
        -Value "Open CMD here" `
        -PropertyType String `
        -Force | Out-Null

    New-ItemProperty `
        -Path $RegistryPath `
        -Name "Icon" `
        -Value "`"$CmdPath`"" `
        -PropertyType String `
        -Force | Out-Null

    $command = "`"$CmdPath`" /K cd /D `"$TargetPlaceholder`""
    Set-RegistryDefaultValue -Path $commandPath -Value $command
}

$cmdPath = Get-CmdPath

if (-not $cmdPath) {
    Write-Host "Command Prompt was not found." -ForegroundColor Red
    Write-Host "Could not locate cmd.exe on this system." -ForegroundColor Yellow
    exit 1
}

Add-CmdContextMenuEntry `
    -RegistryPath "HKCU:\Software\Classes\Directory\shell\OpenCMDHere" `
    -TargetPlaceholder "%1" `
    -CmdPath $cmdPath

Add-CmdContextMenuEntry `
    -RegistryPath "HKCU:\Software\Classes\Directory\Background\shell\OpenCMDHere" `
    -TargetPlaceholder "%V" `
    -CmdPath $cmdPath

Write-Host ""
Write-Host "CMD context menu entries installed successfully." -ForegroundColor Green
Write-Host "Detected CMD path: $cmdPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "If you are using Windows 11, the option may appear under 'Show more options'." -ForegroundColor Yellow
