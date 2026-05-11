#!/system/bin/sh

resetprop -p persist.adb.notify 1 2>/dev/null || resetprop persist.adb.notify 1 2>/dev/null || true
resetprop persist.adb.notify 1 2>/dev/null || true
cmd notification unsnooze "-1|android|26|null|1000" >/dev/null 2>&1 || true
cmd notification unsnooze "-1|android|32|null|1000" >/dev/null 2>&1 || true
