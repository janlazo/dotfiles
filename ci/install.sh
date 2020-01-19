#!/bin/sh
set -ex
cd "$(dirname "$0")/.."

pwsh -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned << 'PS1'
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name PSscriptAnalyzer -Scope CurrentUser
PS1

docker pull koalaman/shellcheck
