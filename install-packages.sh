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

brew_formulae=(
    bat
    chezmoi
    curl
    docker
    docker-buildx
    docker-compose
    gh
    git
    git-delta
    git-lfs
    gnu-sed
    just
    kubernetes-cli
    kustomize
    lsd
    ripgrep
    snowflake-cli
    starship
    tree
    wget
)

brew_casks=(
    1password-cli
    discord
    firefox
    font-hack-nerd-font
    google-drive
    iterm2
    keepassxc
    keepingyouawake
    ngrok
    obsidian
    raycast
    rectangle
    slack
    spotify
    visual-studio-code
)

uv_tools=(
    asciinema
    batrachian-toad
    cookiecutter
    marimo
    pgcli
    prek
    "python-lsp-server[all]"
    rich-cli
    ruff
    ty
    yq
)

brew install "${brew_formulae[@]}"
brew install --cask "${brew_casks[@]}"

uv tool install "xonsh[full]" --with xontrib-vox
uv tool install llm --with llm-anthropic --with llm-fragments-pypi
for tool in "${uv_tools[@]}"; do
    uv tool install "$tool"
done
