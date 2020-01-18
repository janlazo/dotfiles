#!/bin/sh
set -ex
cd "$(dirname "$0")/.."
bash -n unix/.bash*
docker pull 'koalaman/shellcheck:v0.7.0'
docker run --rm -v "$PWD:/mnt" 'koalaman/shellcheck:v0.7.0' -s bash unix/.bash*
