# Using PowerShell, install Posh-Git and Oh-My-Posh:
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# install PSReadline
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# Theme
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
