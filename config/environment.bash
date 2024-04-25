#!/usr/bin/env bash
# place all `export` keyword declarations at the start for bash v3 compatibility:
# shellcheck disable=SC2034
# export NVM_DIR HOMEBREW_ARCH PYENV_VERSION HOMEBREW_RUBY_VERSION # ...

export GHIDRA_INSTALL_DIR

GHIDRA_INSTALL_DIR="$(ls -d "$HOME"/Ghidra/ghidra_*_PUBLIC | tail -n1)"