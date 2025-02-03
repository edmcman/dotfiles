#!/usr/bin/env bash
# place all `export` keyword declarations at the start for bash v3 compatibility:
# shellcheck disable=SC2034
# export NVM_DIR HOMEBREW_ARCH PYENV_VERSION HOMEBREW_RUBY_VERSION # ...

export GHIDRA_INSTALL_DIR

GHIDRA_INSTALL_DIR="$(ls -d "$HOME"/Ghidra/ghidra_*_PUBLIC | sort -t_ -k2,2 | tail -n1)"

# New versions of python's certifi don't know how to find built-in SSL
# certificates apparently.  Need this to support Zscaler MitM.
[[ -f /etc/ssl/certs/ca-certificates.crt ]] && export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt || true
# openai needs this (still certifi related)
[[ -f /etc/ssl/certs/ca-certificates.crt ]] && export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt || true

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init - bash)" || true

# conda
# see activate_conda in interactive.{sh,fish}
