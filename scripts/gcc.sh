#!/bin/bash -e

# make --always-make --dry-run \
#  | grep -wE 'gcc|g\+\+' \
#  | grep -w '\-c' \
#  | jq -nR '[inputs|{directory:".", command:., file: match(" [^ ]+$").string[1:]}]' \
#  > compile_commands.json

make --always-make --dry-run \
  | rg -w 'gcc|g\+\+' \
  | rg -w '\-c' \
  | jq -nR '[inputs | {directory:$ENV.PWD, command:., file: match(" [^ ]+$").string[1:]}]' \
  > "${1:-compile_commands.json}"
