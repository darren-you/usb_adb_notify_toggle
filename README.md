# USB ADB Notify Toggle Magisk 模块

这个 Magisk 模块用于切换 Android 的 USB 调试常驻通知，核心方式是写入 `persist.adb.notify`。

默认行为：隐藏“已连接到 USB 调试”通知。

## 原理

AOSP `UsbDeviceManager.updateAdbNotification()` 会读取 `persist.adb.notify`：

- `persist.adb.notify=0`：不显示 USB 调试通知。
- `persist.adb.notify=1`：恢复 Android 默认显示行为。

模块在开机早期通过 `post-fs-data.sh` 写入属性，在 late start 阶段通过 `service.sh` 补做当前通知隐藏。已经存在的通知会通过 `cmd notification snooze` 暂时隐藏。

## 安装

下载 release 中的 `usb_adb_notify_toggle-v1.0.1.zip`，在 Magisk 中安装，然后重启。

也可以本地构建：

```sh
./scripts/build.sh
```

构建产物会生成在 `dist/`。

## 使用

可以在 Magisk 模块列表里点击本模块的 Action 按钮切换，也可以执行：

```sh
su -c usb-adb-notify status
su -c usb-adb-notify off
su -c usb-adb-notify on
su -c usb-adb-notify toggle
```

`off` 会设置 `persist.adb.notify=0`，隐藏 USB 调试通知。

`on` 会设置 `persist.adb.notify=1`，恢复系统默认显示行为。

## 注意

- 本模块只处理 USB 调试通知，不处理“正在通过 USB 为此设备充电”通知。
- `post-fs-data.sh` 会在开机早期写入属性，`service.sh` 会在晚启动阶段补做当前通知隐藏。
- 从隐藏切回显示时，通知不一定立刻重新出现；通常需要重插 USB、切换 USB 调试或重启后触发系统重新发通知。
- 卸载模块时会恢复 `persist.adb.notify=1`，避免把设备长期留在隐藏状态。

## 目录结构

```text
module/
  META-INF/com/google/android/
  action.sh
  common.sh
  customize.sh
  module.prop
  post-fs-data.sh
  service.sh
  system/bin/usb-adb-notify
  uninstall.sh
scripts/
  build.sh
```

## 参考资料

- AOSP `UsbDeviceManager`：<https://android.googlesource.com/platform/frameworks/base/+/5ac72a2/services/java/com/android/server/usb/UsbDeviceManager.java>
- Magisk Developer Guides：<https://magisk.readthedocs.io/en/latest/developers/guides.html>

## License

GPL-3.0。模块安装器脚本来自 Magisk 官方模块 installer 机制，按 GPL 授权发布更稳妥。
