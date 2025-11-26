#!/usr/bin/env fish

#echo hello from interactive.fish

alias bat=batcat

# https://superuser.com/a/944589/130232
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

function activate_conda
    source /opt/conda/etc/fish/conf.d/conda.fish
end

# pyenv
test -d $PYENV_ROOT; and pyenv init - | source

# asdf
set _asdf_shims "$HOME/.asdf/shims"
# Somehow dorothy orders these pretty strangely.
#if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
#end
set --erase _asdf_shims

# Load public aliases
source "$DOROTHY/user/config/alias.sh"
