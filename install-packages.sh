#!/bin/bash

set -euo pipefail

# Install Homebrew
if [ ! "$(which brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    PATH="/opt/homebrew/bin:$PATH"
fi

# Install uv
if [ ! "$(which uv)" ]; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    PATH="$HOME/.local/bin:$PATH"
fi

brew_formulae="\
    1password-cli \
    bat \
    chezmoi \
    curl \
    docker \
    docker-buildx \
    docker-compose \
    gh \
    git \
    git-delta \
    git-lfs \
    gnu-sed \
    gnupg \
    just \
    kubernetes-cli \
    kustomize \
    lsd \
    pinentry-mac \
    ripgrep \
    snowflake-cli \
    starship \
    tree \
    wget \
"

brew_casks="\
    font-hack-nerd-font \
    gpg-suite \
    keepassxc \
    keepingyouawake \
    ngrok \
    obsidian \
"

uv_tools="\
    asciinema \
    batrachian-toad \
    cookiecutter \
    marimo \
    pgcli \
    prek \
    python-lsp-server[all] \
    rich-cli \
    ruff \
    ty \
    yq \
"

brew install $brew_formulae
brew install --cask $brew_casks

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx

uv tool install xonsh[full] --with xontrib-vox
uv tool install llm --with llm-anthropic --with llm-fragments-pypi
echo "$uv_tools" | xargs -n 1 uv tool install
