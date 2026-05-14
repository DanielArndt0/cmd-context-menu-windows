# CMD Context Menu for Windows

Simple scripts to add Command Prompt options to the Windows context menu.

## Quick Install

Run this command in **PowerShell**:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/DanielArndt0/cmd-context-menu-windows/main/scripts/install.ps1 | iex"
```

After running it, Windows will show the following option in the context menu:

```text
Open CMD here
```

## Uninstall

Run this command in **PowerShell**:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/DanielArndt0/cmd-context-menu-windows/main/scripts/uninstall.ps1 | iex"
```

This removes all context menu entries added by this project.

## What This Project Adds

- `Open CMD here` when right-clicking folders.
- `Open CMD here` when right-clicking inside a folder background.
- User-level installation using `HKEY_CURRENT_USER`.
- No administrator permission required.
- Includes an uninstall script.

> On Windows 11, the option may appear under **Show more options**, because this method uses the classic Windows context menu.

## Requirements

- Windows 10 or Windows 11.
- PowerShell.
- Command Prompt available on Windows.

## Manual Installation

If you prefer to download the project and run it locally, open PowerShell inside the project folder and execute:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\install.ps1
```

## Manual Uninstall

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\uninstall.ps1
```

## Alternative Installation Using `.reg` Files

This project also includes a registry file option:

```text
registry/install.reg
```

This file uses the default Windows Command Prompt path:

```text
C:\Windows\System32\cmd.exe
```

If your Windows installation uses a different system path, prefer using `install.ps1`, because it uses the current system environment to detect `cmd.exe`.

To remove the integration using a registry file, run:

```text
registry/uninstall.reg
```

## Security

The scripts only modify registry keys under:

```text
HKEY_CURRENT_USER\Software\Classes
```

This means the changes apply only to the current Windows user and do not modify system-wide settings.

The following registry entries are created:

```text
HKEY_CURRENT_USER\Software\Classes\Directory\shell\OpenCMDHere
HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\OpenCMDHere
```

## License

This project is licensed under the MIT License.
