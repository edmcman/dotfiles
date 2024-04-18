#!/usr/bin/env bash
# do not use `export` keyword in this file:
# shellcheck disable=SC2034

# load the default configuration
source "$DOROTHY/config/git.bash"

# Used by `setup-git`, `ssh-helper`
# You can use `setup-git --configure` to configure these.

GPG_SIGNING_KEY=''
GPG_SIGNING_AGENT=''
SSH_IDENTITY_AGENT='default'

GIT_DEFAULT_BRANCH='main'
GIT_PROTOCOL='https'
GIT_NAME='Edward J. Schwartz'
GIT_EMAIL='moo.git.domain.edmcman@xoxy.net'
MERGE_TOOL='meld'
GITHUB_USERNAME='edmcman'
GITLAB_USERNAME=''
