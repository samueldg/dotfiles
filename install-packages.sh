#!/bin/bash

set -euo pipefail

# Install Homebrew
if [ ! "$(command -v brew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install uv
if [ ! "$(command -v uv)" ]; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

brew_formulae="\
    1password-cli \
    bat \
    chezmoi \
    curl \
    docker \
    docker-buildx \
    docker-compose \
    font-hack-nerd-font \
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
    starship \
    tldr \
    tree \
    wget \
"

brew_casks="\
    gpg-suite \
    keepassxc \
    keepingyouawake \
    ngrok \
"

uv_packages="\
    asciinema \
    black \
    cookiecutter \
    hatchling \
    pgcli \
    poetry \
    pre-commit \
    py-spy \
    python-lsp-server[all] \
    rich-cli \
    ruff \
    snakeviz \
    yq \
"

brew install $brew_formulae
brew install --cask $brew_casks

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx

uv tool install xonsh[full] --with xontrib-vox
uv tool install llm --with llm-anthropic --with llm-mlx
uv tool install aider-chat --with playwright
echo "$uv_packages" | xargs -n 1 uv tool install
