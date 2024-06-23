#!/bin/bash
# compose the full nixpkgs repo with overlayfs

channels="$HOME/.nix-defexpr/channels"
workspace="$HOME/apps/nixpkgs/overlayfs"
target="$channels/nixpkgs-git"

fuse-overlayfs -o "lowerdir=$channels/nixpkgs,upperdir=$workspace/../repo,workdir=$workspace/workdir" "$target"
## fusermount -u "$target"

export GIT_WORK_TREE=$channels/nixpkgs
export GIT_DIR=$workspace/../repo/.git
git --work-tree="$GIT_WORK_TREE" --git-dir="$GIT_DIR" status
