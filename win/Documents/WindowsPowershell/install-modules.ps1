if ($PSVersionTable.PSVersion.Major -lt 5) {
  return
}
@('PSReadline').ForEach({
  Install-Module -Scope CurrentUser -Name $_ `
    -Force -SkipPublisherCheck -AllowClobber `
})
