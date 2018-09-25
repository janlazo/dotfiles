if ($PSVersionTable.PSVersion.Major -lt 5) {
    return
}
@('PSReadline', 'Pscx').ForEach({
    Install-Module -Force -Scope CurrentUser -SkipPublisherCheck -AllowClobber `
        -Name $_
})
