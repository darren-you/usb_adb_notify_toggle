MODDIR=${MODDIR:-${0%/*}}
CONFIG="$MODDIR/config"
PROP_NAME="persist.adb.notify"
ADB_NOTIFICATION_KEY="-1|android|26|null|1000"
USB_CONNECTION_NOTIFICATION_KEY="-1|android|32|null|1000"
SNOOZE_MS="315360000000"

normalize_value() {
  case "$1" in
    1|on|show|enable|enabled|true)
      echo 1
      ;;
    *)
      echo 0
      ;;
  esac
}

read_notify() {
  local value
  value="$(sed -n 's/^notify=//p' "$CONFIG" 2>/dev/null | head -n 1)"
  normalize_value "$value"
}

write_notify() {
  local value
  value="$(normalize_value "$1")"
  echo "notify=$value" > "$CONFIG"
  chmod 0644 "$CONFIG" 2>/dev/null || true
}

apply_prop() {
  local value
  value="$(normalize_value "$1")"

  resetprop -p "$PROP_NAME" "$value" 2>/dev/null || resetprop "$PROP_NAME" "$value" 2>/dev/null || true
  resetprop "$PROP_NAME" "$value" 2>/dev/null || true
}

apply_notify() {
  local value
  value="$(normalize_value "$1")"

  apply_prop "$value"

  if [ "$value" = "0" ]; then
    cmd notification snooze --for "$SNOOZE_MS" "$ADB_NOTIFICATION_KEY" >/dev/null 2>&1 || true
    cmd notification snooze --for "$SNOOZE_MS" "$USB_CONNECTION_NOTIFICATION_KEY" >/dev/null 2>&1 || true
  else
    cmd notification unsnooze "$ADB_NOTIFICATION_KEY" >/dev/null 2>&1 || true
    cmd notification unsnooze "$USB_CONNECTION_NOTIFICATION_KEY" >/dev/null 2>&1 || true
  fi
}

print_status() {
  local configured current mode
  configured="$(read_notify)"
  current="$(getprop "$PROP_NAME")"
  if [ "$configured" = "0" ]; then
    mode="hidden"
  else
    mode="shown"
  fi

  echo "mode=$mode"
  echo "config notify=$configured"
  echo "$PROP_NAME=$current"
  echo "adb_notification_key=$ADB_NOTIFICATION_KEY"
  echo "usb_connection_notification_key=$USB_CONNECTION_NOTIFICATION_KEY"
}
