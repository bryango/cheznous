#!/bin/bash
# toggle wine wechat window

# set -x  ## for debugging

KEYS=ctrl+alt+w
WMCLASS_WECHAT="wechat"
WMCLASS_WINE="Wine|.exe"

which xdotool 1>/dev/null || exit 1
which pgrep   1>/dev/null || exit 1

# set class to `wechat` for themed icon
# ... no longer necessary for <vufa/deepin-wine-wechat-arch>
function set-window-class-wechat {
    xdotool \
        search --classname "$WMCLASS_WECHAT" \
        set_window --class "$WMCLASS_WECHAT"
}

# send keys
for pid in $(pgrep explorer.exe); do
    xdotool \
        search \
            --pid "$pid" \
            --class "$WMCLASS_WINE" \
        key \
            --clearmodifiers "$KEYS" \
    && exit 0
    # ... `--clearmodifiers` improves continuous toggling
done

# otherwise, error out
exit 1
