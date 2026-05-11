#!/system/bin/sh

MODDIR=${0%/*}
. "$MODDIR/common.sh"

if [ ! -f "$CONFIG" ]; then
  write_notify 0
fi

apply_prop "$(read_notify)"
