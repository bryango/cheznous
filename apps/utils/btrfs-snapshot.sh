#!/bin/bash
# btrfs snapshot setup

set -x  # echo
set -e  # quit on error
name=$1

MNT_BTRSYSTEM=/run/media/root/btrsystem

ls -alF --color=always /.snapshots
if [[ -z $name ]]; then
    # shellcheck disable=SC2034
    ERROR="a name for the snapshot is required"
    exit 1
fi

sudo mount --mkdir "$MNT_BTRSYSTEM"

# sudo --reset-timestamp: ask for password confirmation
for subvol in root home; do
    # readwrite
    sudo --reset-timestamp \
        btrfs subvolume snapshot "$MNT_BTRSYSTEM"/{@"$subvol",@snapshots/"$subvol"-"$name"}
        # `-r` flag for readonly
done

# cleanup
target="$MNT_BTRSYSTEM"/@snapshots/root-"$name"
{
    cd "$target" || exit 1
    sudo --reset-timestamp /bin/rm -rI "$target"/opt/{anaconda,Mathematica}
}
