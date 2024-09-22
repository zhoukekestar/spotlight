#!/usr/bin/env sh

# ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
# cd "$ABSPATH"
cd "$(dirname "$0")"
PATH=$PATH:./node_modules/.bin

/Applications/V2rayU.app/Contents/Resources/v2ray-core/v2ray run -c ~/v2ray-config.json &
# osascript -e  'tell application "Terminal"' -e 'set the bounds of window 1 to {0, 0, 10, 10}' -e 'end tell'

# osascript ./src/ocr.applescript

# 需要立即关闭当前窗口的，执行下述代码，不需要的，则注释即可
osascript -e 'tell application "Terminal" to close (every window whose name contains "cli-vpn.command")' &
