#!/bin/sh
cd "$(dirname "$0")/.."
bash -n unix/.bash*
shellcheck -s bash -e SC1090 -e SC2154 -e SC2139 unix/.bash*
