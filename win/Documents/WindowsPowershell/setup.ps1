# Enable user to run powershell scripts
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# Install Nuget
Find-Module

# Trust Powershell Gallery, central repo to download Powershell Modules
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted 
