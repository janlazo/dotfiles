`Microsoft.PowerShell_profile.ps1` is the user's `$PROFILE`.

`setup.ps1` allows Powershell to source `$PROFILE` on startup
and install modules from [Powershell Gallery](https://www.powershellgallery.com/).

`install-modules.ps1` installs modules, imported in `$PROFILE`.

`profile.cs` is for C# helper functions that Powershell can compile on the fly.
Pre-compile it with `csc.exe` (requires Visual Studio).


```dosbatch
csc.exe /t:library profile.cs
```

Assume that all code in this directory require Powershell 5+.
