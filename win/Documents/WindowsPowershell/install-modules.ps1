if ($PSVersionTable.PSVersion.Major -lt 5) {
  return
}
@('PSReadline', 'Pscx').ForEach({
  Install-Module -Scope CurrentUser -Name $_ `
    -Force -SkipPublisherCheck -AllowClobber `
})
