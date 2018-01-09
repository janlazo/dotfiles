`setup.ps1` allows Powershell to source `$PROFILE` (if it exists) and install Powershell modules from [Powershell Gallery](https://www.powershellgallery.com/).

`install-modules.ps1` installs Powershell modules that I need for my `$PROFILE`.

`Microsoft.PowerShell_profile.ps1` is my `$PROFILE` template.

`profile.cs` is for helper functions that require C# classes. Powershell can compile it on the fly but it can be compiled with  `csc.exe` (requires Visual Studio) to create `profile.dll`.
