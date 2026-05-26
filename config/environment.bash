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
# primp needs this
[[ -f /etc/ssl/certs/ca-certificates.crt ]] && export PRIMP_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt || true
# node needs this
[[ -f /etc/ssl/certs/ca-certificates.crt ]] && export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt || true

JDK_JAVA_OPTIONS=""

# Claude Code gets stuck a lot and it's annoying to have to wait for it to timeout.  Set a shorter timeout for now.
# https://code.claude.com/docs/en/env-vars
export API_TIMEOUT_MS=600000 # 10 minutes, default
export CLAUDE_STREAM_IDLE_TIMEOUT_MS=60000 # clamped to 5 minutes minimum anyway :-(
export CLAUDE_ENABLE_STREAM_WATCHDOG=1
export CLAUDE_ENABLE_BYTE_WATCHDOG=1
export CLAUDE_ASYNC_AGENT_STALL_TIMEOUT_MS=60000

# Java on mac, use the system CAs
if test -f /Library/Keychains/System.keychain; then
  export JAVA_TOOL_OPTIONS
  export JDK_JAVA_OPTIONS
  JAVA_TOOL_OPTIONS="-Djavax.net.ssl.trustStoreType=KeychainStore -Djavax.net.ssl.trustStorePath=/Library/Keychains/System.keychain $JAVA_TOOL_OPTIONS"
  JDK_JAVA_OPTIONS="-Djavax.net.ssl.trustStoreType=KeychainStore -Djavax.net.ssl.trustStorePath=/Library/Keychains/System.keychain $JDK_JAVA_OPTIONS"
fi

if which clang++-18 &> /dev/null; then
  export CC CXX
  CC=clang-18
  CXX=clang++-18
fi

# nvcc
if test -f /usr/local/cuda-12.4/bin/nvcc; then
  export PATH
  PATH="$PATH:/usr/local/cuda-12.4/bin"
fi

# llama.cpp
if test -f ~/Projects/llama.cpp/build/bin/llama-server; then
  export PATH
  PATH="$PATH:$HOME/Projects/llama.cpp/build/bin"
fi

# java proxy and ssl options
export JDK_JAVA_OPTIONS="-Djdk.rmi.ssl.client.enableEndpointIdentification=false $JDK_JAVA_OPTIONS"
export JDK_JAVA_OPTIONS="-Djava.net.useSystemProxies=true $JDK_JAVA_OPTIONS"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]
then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
# conda
# see activate_conda in interactive.{sh,fish}

# A federated server...
export DEBUGINFOD_URLS="https://debuginfod.elfutils.org/"

# debuginfod on Ubuntu
if [[ -f /etc/os-release ]] && grep -q "^ID=ubuntu" /etc/os-release
then
  export DEBUGINFOD_URLS="$DEBUGINFOD_URLS https://debuginfod.ubuntu.com"
fi

function after_everything {
  # This is important to have in environment.bash for non-interactive shells.
  # The after_everything hook is important so that the asdf shims are in PATH before /usr/bin
  ASDF_SHIMS_DIR="$HOME/.asdf/shims"
  if [[ -d "$ASDF_SHIMS_DIR" ]]
  then
    export PATH="$ASDF_SHIMS_DIR:$PATH"
  fi

  # put homebrew python on path
  if test -d /opt/homebrew/opt/python@3.14/libexec/bin; then
    export PATH
    PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"
  fi

}
