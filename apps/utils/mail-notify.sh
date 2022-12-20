#!/bin/bash
# notify for mailnag

count=$1
account=$2
sender=$3
subject=$4

# https://wiki.archlinux.org/title/Dunst#Dunstify
# dunstify --help
response=$(
	dunstify "$account" "[+$count] <i>$sender</i>: <b>$subject</b>" \
		--icon=mail-message-new \
		--action='2,Browse' \
		--hints=int:transient:1
)
if [[ $response -ne 2 ]]; then
	exit
fi

if [[ $account == http* ]]; then
	xdg-open "$account" &>/dev/null & disown
	exit
fi

server=${account##*@}
if [[ $server != *mail* ]]; then
	server="mail.$server"
fi
server="https://$server"

exec xdg-open "$server" &>/dev/null & disown
exit
