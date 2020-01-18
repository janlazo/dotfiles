#!/bin/sh
cd "$(dirname "$0")/.."
bash -n unix/.bash*
shellcheck -s bash unix/.bash*
