function Prompt
{
    # Prep
    $origLastExitCode = $LASTEXITCODE;

    # Core
    $curpath = $executionContext.SessionState.Path.CurrentLocation.Path;
    $homepathRegex = [regex]::Escape($env:USERPROFILE) + '(\\.*)*$';
    $relpath = $($curpath -replace $homepathRegex, '~$1');
    Write-Host -ForegroundColor Green -nonewline "[$env:USERNAME]";
    Write-Host -ForegroundColor Blue             " $relpath";

    # Powershell Prompt Level
    $prompt = 'PS' + $('>' * ($nestedPromptLevel + 1));
    Write-Host -ForegroundColor White -nonewline $prompt;

    # Cleanup
    $LASTEXITCODE = $origLastExitCode;

    return ' ';
}

function Is-Admin
{
    $user   = [Security.Principal.WindowsIdentity]::GetCurrent();
    $admin  = [Security.Principal.WindowsBuiltInRole]::Administrator;
    $result = ([Security.Principal.WindowsPrincipal]$user).IsInRole($admin);

    return [bool]$result;
}

function SymLink
{
    Param(
        [String]$src  = "",
        [String]$dest = $PWD.Path
    )

    if (-Not (IsAdmin))
    {
        Write-Output "Need admin permissions to make symlinks";
        return;
    }

    # Setup absolute paths of the source and destination files/folders
    $src = $(Get-Item -Path $src.trim()).FullName;
    $dest = $dest.trim();
    $dest_d = $(Get-Item -Path $(Split-Path $dest -parent)).FullName;
    $dest_f = $(Split-Path $dest -leaf);
    $flag = "";

    # Setup the directory flag
    if (Test-Path $src -pathType container)
    {
        $flag = "/D";
    }

    # Make the symlink
    cmd.exe /c mklink $flag "$dest_d\$dest_f" "$src";
}

# Silent wrapper of Get-Command
function Has-App
{
    Param([String]$app = "")
    Get-Command -ErrorAction SilentlyContinue -commandType Application $app
}

# Setup cmd.exe for Visual Studio 2017 so cl.exe has access to core libraries.
#
# References
# - https://ss64.com/nt/syntax-64bit.html
# - https://www.appveyor.com/docs/lang/cpp/
function Setup-VS2017
{
    if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64")
    {
        $bits = '64'
    }
    else
    {
        $bits = '32'
    }

    cmd.exe /k "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars$bits.bat"
}

if ($(Has-App fzf) -and $(Has-App sift)) {
    $env:FZF_DEFAULT_COMMAND = 'sift --targets . 2> nul';
}

# Powershell 3 modules are not backward compatible
if ($PSVersionTable.PSVersion.Major -lt 3) {
    return;
}

# vi/emacs keybinds
Import-Module PSReadline;
Set-PSReadlineOption -EditMode Emacs -BellStyle Visual -HistoryNoDuplicates;

# emulate unix programs
Import-Module Pscx;
