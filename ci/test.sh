#!/bin/sh
cd $(dirname "$0")/..
bash -n unix/.bashrc
shellcheck -s bash -e SC1090 -e SC2142 -e SC2154 -e SC2139 unix/.bashrc
