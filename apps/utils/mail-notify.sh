#!/bin/bash
# notify for mailnag

count=$1
account=$2
sender=$3
subject=$4

code=$(
	dunstify "$account" "[+$count] <i>$sender</i>: <b>$subject</b>" \
		--icon=mail-message-new \
		--action='2,Browse' \
		--hints=int:transient:1
)

if [[ $account == http* ]]; then
	exec xdg-open "$account"
fi

server=${account##*@}
if [[ $server != *mail* ]]; then
	server="mail.$server"
fi
server="https://$server"

if [[ $code -eq 2 ]]; then
	exec xdg-open "$server"
fi
