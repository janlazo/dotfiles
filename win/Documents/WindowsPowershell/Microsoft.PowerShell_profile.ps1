if (Test-Path "$PSScriptRoot/profile.dll") {
    Add-Type -Path "$PSScriptRoot/profile.dll"
}
elseif (Test-Path "$PSScriptRoot/profile.cs") {
    Add-Type -Path "$PSScriptRoot/profile.cs"
}

function Prompt {
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

# Silent wrapper of Get-Command
function Which {
    Param([String]$app = "")
    Get-Command -ErrorAction SilentlyContinue -commandType Application $app
}

# Setup cmd.exe for Visual Studio 2017 so cl.exe has access to core libraries.
#
# References
# - https://ss64.com/nt/syntax-64bit.html
# - https://www.appveyor.com/docs/lang/cpp/
function Setup-VS2017 {
    $bits = @('64', '32')[$env:PROCESSOR_ARCHITECTURE -eq 'x86']
    cmd.exe /k set '"VSCMD_START_DIR=%CD%"' '&' "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars$bits.bat"
}

# Powershell 3 modules are not backward compatible
if ($PSVersionTable.PSVersion.Major -lt 3) {
    return;
}

# vi/emacs keybinds
Import-Module PSReadline;
Set-PSReadlineOption -EditMode Emacs -BellStyle Visual -HistoryNoDuplicates;
if (Which fzf) {
    Set-PSReadlineKeyHandler -Chord Ctrl+R -ScriptBlock {
        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        $file = (Get-PSReadlineOption).HistorySavePath
        $result = Get-Content $file | Select-Object -Unique | fzf

        [Microsoft.Powershell.PSConsoleReadline]::RevertLine()
        if ($LASTEXITCODE) {
            [Microsoft.Powershell.PSConsoleReadline]::Insert($line)
        }
        else {
            [Microsoft.Powershell.PSConsoleReadline]::Insert($result)
        }
    }
}

# emulate unix programs
Import-Module Pscx;
