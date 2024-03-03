#!/bin/bash
# add missing zsh functions for executables
# for this to work, one has to export $FPATH in e.g. ~/.zshrc

fpath_prepend() {
  if [[ -z $FPATH ]]; then
    >&2 echo "\$FPATH empty, not adding: $*"
    exit 0
  fi

  local executable exec_path extra_fpath;
  extra_fpath=""

  for executable in "$@"; do
    if exec_path=$(which "$executable" 2>/dev/null); then
      extra_fpath="$extra_fpath$(dirname "$exec_path")/../share/zsh/site-functions:"
    fi
  done

  export FPATH="$extra_fpath$FPATH"
}
