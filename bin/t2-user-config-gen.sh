#!/bin/sh

usage() {
  echo "Coming soon..."
}

gen_config() {
  local _src=${1}
  local _dest={2}

  . $_src
}

T2_CONFIG_DIR="$HOME/.config/t2"
T2_LIB_DIR="$HOME/.local/lib/t2"
T2_STATE_DIR="$XDG_RUNTIME_DIR/t2"

declare -a MONITORS

while getopts :l o; do
  case $o in
    l)
      LOG_CONFIGS=1
      ;;
  esac
done

shift $(( $OPTIND - 1 ))

if [[ "${LOG_CONFIGS+x}" == "x" ]]
then
  for file in $T2_CONFIG_DIR/generators/*
  do
    . $file > $T2_STATE_DIR/${file##*/}
  done
else
  # Just show the processed output
  for file in $T2_CONFIG_DIR/generators/*
  do
    . $file
  done
fi

