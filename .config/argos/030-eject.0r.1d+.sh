#!/usr/bin/env bash
# Spin down HDD - Argos Widget

echo "| iconName=media-removable"
echo "---"

fontset="size=10.5"
bashcmd="bash='udisksctl-off' terminal=true"

if [ "$ARGOS_MENU_OPEN" == "true" ]; then

	export GREP_COLORS=ne
	drives_info=$(lsblk-more \
		| tr '\n' '\r' \
		| sed -E 's/ *\r/\\n/g' \
		| sed -E 's/[[:space:]\\n]*$//g')  # Remove trailing whitespace & the last newline

	echo "<tt>$drives_info</tt> | $fontset $bashcmd"

else
	echo "Loading... | $fontset $bashcmd"
fi
