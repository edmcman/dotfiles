#!/usr/bin/env bash
# do not use `export` keyword in this file:
# shellcheck disable=SC2034

# load the default configuration
source "$DOROTHY/config/editors.bash"

# Used by `setup-environment-commands`

# Our editors in order of preference
TERMINAL_EDITORS=(
	# editors with an obvious newb friendly UX
	'nano' # setup-util-nano,
	'emacs'
)
GUI_EDITORS=(
	'code' # setup-util-vscode
	'gedit'             # linux default
	'gnome-text-editor' # fedora default
	# 'TextEdit'          # macos default
)
