#!/bin/sh
set -ex
cd "$(dirname "$0")/.."

bash -n unix/.bash*
docker run --rm -v "$PWD:/mnt" koalaman/shellcheck -s bash unix/.bash*

pwsh -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned ci/test.ps1
