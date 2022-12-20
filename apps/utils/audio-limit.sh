#!/bin/bash
# limit volume

# debug=1

active_port=$(pactl list sinks \
	| grep -i 'active port' \
	| xargs | sed -E 's/(.*:)[ ]*(.*)/\2/g'
)
[[ -n $debug ]] && >&2 echo "# port: $active_port"

# $battery_status can be set via env
[[ -z $battery_status ]] \
	&& battery_status=$(cat /sys/class/power_supply/BAT1/status)

[[ -n $debug ]] && >&2 echo "# batt: $battery_status"

if [[ "$active_port" == "analog-output-speaker" ]] \
&& [[ "$battery_status" == "Discharging" ]];
then
	>&2 echo "### $(basename "$0"): muting the speaker"
	pactl set-sink-volume @DEFAULT_SINK@ 1%
	pactl set-sink-mute   @DEFAULT_SINK@ 1
fi

# vim: set noexpandtab:
