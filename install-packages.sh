#!/bin/bash

set -euo pipefail

# Install Homebrew
if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Only affects this script's environment, not the shell profile
    for brew_prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
        if [ -x "$brew_prefix/bin/brew" ]; then
            eval "$("$brew_prefix/bin/brew" shellenv)"
            break
        fi
    done
fi

# Install uv
if ! command -v uv >/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    PATH="$HOME/.local/bin:$PATH"
fi

uv python install 3.14

brew bundle --file="$(dirname -- "${BASH_SOURCE[0]}")/Brewfile"
