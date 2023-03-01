#!/bin/bash

set -euo pipefail

brew_formulae="\
    asciinema \
    bat \
    black \
    chezmoi \
    curl \
    git \
    git-delta \
    git-lfs \
    gnu-sed \
    gnupg \
    kubernetes-cli \
    kustomize \
    pgcli \
    pinentry-mac \
    pipx \
    pre-commit \
    pyenv \
    pyenv-virtualenv \
    python-yq \
    ripgrep \
    tldr \
    tree \
    wget \
    xonsh \
"

brew_casks="\
    gpg-suite \
    keepassxc \
    keepingyouawake \
    ngrok \
"

pipx_packages="\
    cookiecutter \
    flake8 \
    poetry \
    python-lsp-server \
    rich-cli \
    ruff \
    snakeviz \
"

brew install $brew_formulae
brew install --cask $brew_casks
pipx install $pipx_packages
