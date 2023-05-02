#!/bin/sh

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim

### OpenCV log
### https://github.com/boltgolt/howdy/issues/318
export OPENCV_LOG_LEVEL=ERROR

### WARNING: this may kill gnome!
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

CONDA_ROOT=$HOME/apps/mambaforge
export ELECTRON_TRASH=gio

# hunspell
export DICPATH="$HOME/apps/dicts"

### TeXLive
### ... `man` & `info` is usually clever enough; check `manpath`
# export MANPATH="$MANPATH""$HOME/apps/texlive/latest/texmf-dist/doc/man:"
# export INFOPATH="${INFOPATH+$INFOPATH:}$HOME/apps/texlive/latest/texmf-dist/doc/info"
## ... https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
## To overwrite system binaries:
export PATH="$HOME/apps/texlive/latest/bin/x86_64-linux:$PATH"

### MikTeX
### ... after TeXLive, as an overwrite
export PATH="$HOME/apps/miktex/bin:$PATH"
### https://docs.miktex.org/manual/mthelp.html
# export MIKTEX_VIEW_pdf="xpdf %f"
# export MIKTEX_VIEW_dvi="xpdf %f"
# export MIKTEX_VIEW_ps="xpdf %f"
# export MIKTEX_VIEW_html="google-chrome %f"
# export MIKTEX_VIEW_txt="mousepad %f"

### rustup mirrors
## ... https://mirrors.tuna.tsinghua.edu.cn/help/rustup/
## ... https://rust-lang.github.io/rustup/environment-variables.html
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export PATH="$HOME/.cargo/bin:$PATH"

# ### Android
# export ANDROID_SDK_ROOT=$HOME/apps/Android/SDK
# export PATH=$PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools

# ### Mathematica: reduce graphics lag
# vblank_mode=0

# ### RubyGems
# PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
# export GEM_HOME=$HOME/.gem

# ### Plotinus
# export GTK3_MODULES="${GTK3_MODULES+$GTK3_MODULES:}libplotinus"

# ### TsinghuaNet
# export TSINGHUA_NET_ACCURATE=1
# export PATH="$PATH:$HOME/apps/tsinghua-net/bin"

# ### deepin wine
# export WINE=deepin-wine5
# export WINESERVER=/usr/lib/i386-linux-gnu/deepin-wine5/wineserver

# ### homebrew
# export HOMEBREW_INSTALL_FROM_API=1
# export HOMEBREW_VERBOSE=1
# BREW_BIN=".linuxbrew/bin/brew"
# if [ -r /home/linuxbrew/"$BREW_BIN" ]; then
# 	eval "$(/home/linuxbrew/"$BREW_BIN" shellenv)"
# elif [ -r "$HOME/$BREW_BIN" ]; then
# 	eval "$("$HOME/$BREW_BIN" shellenv)"
# fi

### nix binaries
# export PATH="$HOME/.nix-profile/bin:$PATH"  ### /etc/profile.d/nix-daemon.sh
###### WARNING: this may kill gnome
export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

### conda envs
###### WARNING: this may kill gnome
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:$CONDA_ROOT/share:$CONDA_ROOT/envs/cadabra2/share"

### user binaries
export PATH="$HOME/bin:$PATH"
if echo "$PATH" | grep -q -v "$HOME/.local/bin"; then
    export PATH="$HOME/.local/bin:$PATH"
fi

### AT LAST
export PROFILE_SOURCED=1
