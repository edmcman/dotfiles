# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal dotfiles repository for the [Dorothy](https://github.com/bevry/dorothy) dotfile ecosystem. Lives at `~/.config/dorothy/`. No build system, test suite, or linter — it's shell scripts and configuration only.

## Architecture

**Public vs. private split**: `config/` and `commands/` are public. `priv/` is an encrypted git submodule (Strongbox) holding private commands, config, and dotfiles. The `*.local` symlinks (`commands.local`, `config.local`, `files.local`) point into `priv/` and are gitignored in the public repo.

**Dorothy config convention**: Each config file sources the Dorothy default first, then overrides with user preferences. E.g., `source "$DOROTHY/config/setup.bash"` at the top of `config/setup.bash`.

**Dual-invocable command pattern**: Every command in `commands/` defines a bash function and also fires standalone:
```bash
#!/usr/bin/env bash
function command-name() {
    source "$DOROTHY/sources/bash.bash"
    # ...
}
if test "$0" = "${BASH_SOURCE[0]}"; then
    command-name "$@"
fi
```

**Shell compatibility**: Interactive configs have both `.sh` (bash/zsh) and `.fish` variants. Commands should check OS (macOS vs Linux) when platform-specific behavior is needed.

## Key Environment Details

- `$DOROTHY` — points to the Dorothy installation root
- Zscaler corporate SSL MitM is handled via explicit CA bundle paths in `config/environment.bash`
- GPU workflows (CUDA) for llama.cpp, Ollama Docker, Colab runtime
- Reverse engineering toolchain: Ghidra (+ Ghidrathon), IDA Pro, BinaryNinja