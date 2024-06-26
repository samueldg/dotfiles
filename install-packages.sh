#!/bin/bash

set -euo pipefail

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
    pipx \
    pyenv \
    pyenv-virtualenv \
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

pipx_packages="\
    asciinema \
    black \
    cookiecutter \
    hatchling \
    pgcli \
    poetry \
    pre-commit \
    python-lsp-server[all] \
    rich-cli \
    ruff \
    snakeviz \
    xonsh[full] \
    yq \
"

brew install $brew_formulae
brew install --cask $brew_casks
pipx install $pipx_packages

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
