Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Find-Module

Register-PackageSource -ProviderName NuGet -Name NuGet -Trusted `
  -Location https://www.nuget.org/api/v2
