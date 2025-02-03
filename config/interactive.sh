#!/usr/bin/env sh
# use inline `export VAR=...` statements, for fish compatibility`:
# shellcheck disable=SC2034

# load the default configuration
. "$DOROTHY/config/interactive.sh"

# Loaded by `interactive.sh`
# Must be compatible with fish, zsh, bash

# Tell Dorothy which theme to load, if any.
# Used by `theme.sh` and `theme.fish`
# You can use `select-theme` to configure this.
export DOROTHY_THEME='system'

#echo hello from interactive.sh

if [ -x "$(command -v batcat)" ] && [ ! -x "$(command -v bat)" ]
then
    alias bat=batcat
fi

# Load public aliases
source "$DOROTHY/user/config/alias.sh"

# pyenv
test -d $PYENV_ROOT && eval "$(pyenv init -)"

function activate_conda() {
    source /opt/conda/etc/profile.d/conda.sh
}
