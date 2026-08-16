#!/usr/bin/env bash
#
# Tools not managed by Homebrew (see Brewfile for everything else).
# Idempotent: safe to re-run; each step is skipped if already installed.

set -uo pipefail

log()  { printf "\n\033[1;34m==> %s\033[0m\n" "$*"; }
skip() { printf "\033[0;32m    ✓ %s already installed\033[0m\n" "$*"; }

###############################################################################
# Xcode Command Line Tools (needed by almost everything below)
###############################################################################
if xcode-select -p >/dev/null 2>&1; then
  skip "Xcode Command Line Tools"
else
  log "Installing Xcode Command Line Tools"
  xcode-select --install
  echo "    Re-run this script after the installation finishes."
  exit 1
fi

###############################################################################
# Oh My Zsh + custom plugins
###############################################################################
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  skip "Oh My Zsh"
else
  log "Installing Oh My Zsh"
  # --unattended: don't change default shell / launch zsh mid-script
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  skip "zsh-autosuggestions"
else
  log "Installing zsh-autosuggestions (referenced in .zshrc plugins)"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

###############################################################################
# Version managers
###############################################################################
# nvm (Node)
if [[ -d "$HOME/.nvm" ]]; then
  skip "nvm"
else
  log "Installing nvm"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
fi

# SDKMAN (JVM toolchains)
if [[ -d "$HOME/.sdkman" ]]; then
  skip "SDKMAN"
else
  log "Installing SDKMAN"
  curl -fsSL "https://get.sdkman.io?rcupdate=false" | bash
fi

# rustup (Rust; provides cargo used by Brewfile `cargo` entries)
if [[ -d "$HOME/.rustup" ]]; then
  skip "rustup"
else
  log "Installing rustup"
  curl -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

###############################################################################
# Python tooling
###############################################################################
# uv (+uvx)
if command -v uv >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/uv" ]]; then
  skip "uv"
else
  log "Installing uv"
  curl -fsSL https://astral.sh/uv/install.sh | sh
fi

# poetry
if command -v poetry >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/poetry" ]]; then
  skip "poetry"
else
  log "Installing poetry"
  curl -fsSL https://install.python-poetry.org | python3 -
fi

###############################################################################
# Mobile development
###############################################################################
# Flutter (manual install; .zshrc expects ~/Library/flutter/bin on PATH)
if [[ -d "$HOME/Library/flutter" ]]; then
  skip "Flutter"
else
  log "Installing Flutter (cloning stable channel)"
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/Library/flutter"
fi

# Maestro (mobile UI testing; .zshrc expects ~/.maestro/bin on PATH)
if [[ -d "$HOME/.maestro" ]]; then
  skip "Maestro"
else
  log "Installing Maestro"
  curl -fsSL https://get.maestro.mobile.dev | bash
fi

###############################################################################
# Claude Code (native install → ~/.local/bin/claude)
###############################################################################
if [[ -x "$HOME/.local/bin/claude" ]] || command -v claude >/dev/null 2>&1; then
  skip "Claude Code"
else
  log "Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
fi

log "Done."
echo "Restart your shell (or 'source ~/.zshrc') to pick up new PATH entries."
