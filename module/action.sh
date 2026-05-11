#!/system/bin/sh

MODDIR=${0%/*}
. "$MODDIR/common.sh"

current="$(read_notify)"
if [ "$current" = "0" ]; then
  write_notify 1
  apply_notify 1
  echo "USB debugging persistent notification: shown"
  echo "Reconnect USB or reboot if the notification does not reappear immediately."
else
  write_notify 0
  apply_notify 0
  echo "USB debugging persistent notification: hidden"
fi

print_status
