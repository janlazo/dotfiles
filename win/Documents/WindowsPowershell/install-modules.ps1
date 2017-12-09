$all_modules = @('PSReadline', 'Pscx')

foreach ($module in $all_modules)
{
    if ($module.length -gt 0)
    {
        Install-Module -Force -Scope CurrentUser -Name $module
    }
}
