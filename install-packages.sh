#!/bin/bash

set -euo pipefail

brew_formulae="\
    bat \
    chezmoi \
    curl \
    docker \
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
    oh-my-posh \
    pgcli \
    pinentry-mac \
    pipx \
    pyenv \
    pyenv-virtualenv \
    python-yq \
    ripgrep \
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
    poetry \
    pre-commit \
    python-lsp-server[all] \
    rich-cli \
    ruff \
    snakeviz \
    xonsh[full] \
"

brew install $brew_formulae
brew install --cask $brew_casks
pipx install $pipx_packages

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/bin/docker-compose ~/.docker/cli-plugins/docker-compose
