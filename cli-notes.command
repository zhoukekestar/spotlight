#!/usr/bin/env sh

# ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
# cd "$ABSPATH"
cd "$(dirname "$0")"
PATH=$PATH:./node_modules/.bin

zx ./src/notes.mjs

# 需要立即关闭当前窗口的，执行下述代码，不需要的，则注释即可
osascript -e 'tell application "Terminal" to close (every window whose name contains "cli-notes.command")' &