#!/bin/sh

usage() {
  echo "Coming soon..."
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

case ${#@} in
  0)
    ;;
  *)
    MONITORS=( "${@}" )
    ;;
esac

# Monitor geometry
declare -A MON_WIDTHS
declare -A MON_HEIGHTS
declare -A MON_OFFSETS_X
declare -A MON_OFFSETS_Y

# Monitor panel widths
# Used to set screen edge margins
declare -A MON_PWIDTHS_LEFT
declare -A MON_PWIDTHS_RIGHT
declare -A MON_PWIDTHS_TOP
declare -A MON_PWIDTHS_BOT

. $T2_LIB_DIR/configure-layout

for mon in ${MONITORS[@]}
do
  try_source ${T2_CONFIG_DIR}/layouts/$mon

  tile_gap=${tile_gap:-0}
  top_margin=${top_margin:-${tile_gap}}
  bottom_margin=${bottom_margin:-${tile_gap}}
  left_margin=${left_margin:-${tile_gap}}
  right_margin=${right_margin:-${tile_gap}}

  mon_width=${MON_WIDTHS[$mon]}
  mon_height=${MON_HEIGHTS[$mon]}

  # Panels
  top_panel_height=${MON_PWIDTHS_TOP[$mon]}
  bottom_panel_height=${MON_PWIDTHS_BOT[$mon]}
  left_panel_width=${MON_PWIDTHS_LEFT[$mon]}
  right_panel_width=${MON_PWIDTHS_RIGHT[$mon]}

  # Offsets
  horizontal_offset=${MON_OFFSETS_X[$mon]}
  vertical_offset=${MON_OFFSETS_Y[$mon]}

  if [[ "${LOG_CONFIGS+x}" == "x" ]]
  then
    . $T2_LIB_DIR/generators/layout > $T2_STATE_DIR/$mon
  else
    . $T2_LIB_DIR/generators/layout
  fi
done

