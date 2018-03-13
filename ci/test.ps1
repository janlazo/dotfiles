@('win\Documents\WindowsPowershell\Microsoft.PowerShell_profile.ps1',
  'ci\test.ps1').ForEach({
    $file = $_
    @('CmdletDesign', 'ScriptFunctions', 'ScriptSecurity').ForEach({
        Invoke-ScriptAnalyzer -Path $file -Settings $_
    })
})
