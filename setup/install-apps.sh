#!/bin/bash
# install-apps.sh - Install developer tools and applications on Linux/WSL

set -e

echo ""
echo "### Updating package lists ###"
echo ""
sudo apt-get update

# ─── Developer Tools ─────────────────────────────────────────────────────────

echo ""
echo "### Installing Developer Tools ###"
echo ""

# Git
echo "Installing Git..."
sudo apt-get install -y git

# Python 3
echo "Installing Python 3..."
sudo apt-get install -y python3 python3-pip python3-venv

# OpenJDK 17
echo "Installing OpenJDK 17..."
sudo apt-get install -y openjdk-17-jdk

# curl & build-essentials (needed by nvm / other installers)
sudo apt-get install -y curl build-essential

# NVM (Node Version Manager) + Node.js LTS
echo "Installing NVM..."
if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# Visual Studio Code (skip on headless / pure WSL – install on the Windows side)
if command -v snap &>/dev/null && [ -n "$DISPLAY" ]; then
    echo "Installing Visual Studio Code via snap..."
    sudo snap install code --classic
else
    echo "Skipping VS Code installation (no display / snap not available). Install it on the Windows side for WSL."
fi

# ─── General Applications ────────────────────────────────────────────────────

echo ""
echo "### Installing General Applications ###"
echo ""

# Signal
echo "Installing Signal..."
if ! dpkg -l signal-desktop &>/dev/null; then
    curl -fsSL https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor -o /usr/share/keyrings/signal-desktop-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" \
        | sudo tee /etc/apt/sources.list.d/signal-xenial.list
    sudo apt-get update
    sudo apt-get install -y signal-desktop
fi

# Telegram
echo "Installing Telegram..."
if command -v snap &>/dev/null; then
    sudo snap install telegram-desktop
else
    sudo apt-get install -y telegram-desktop
fi

# Brave Browser
echo "Installing Brave Browser..."
if ! command -v brave-browser &>/dev/null; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
        https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] \
https://brave-browser-apt-release.s3.brave.com/ stable main" \
        | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt-get update
    sudo apt-get install -y brave-browser
fi

# OBS Studio
echo "Installing OBS Studio..."
sudo apt-get install -y obs-studio

# PostgreSQL
echo "Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib

# Blender
echo "Installing Blender..."
if command -v snap &>/dev/null; then
    sudo snap install blender --classic
else
    sudo apt-get install -y blender
fi

# Discord
echo "Installing Discord..."
if command -v snap &>/dev/null; then
    sudo snap install discord
else
    echo "Skipping Discord installation (snap not available). Download manually from https://discord.com."
fi

echo ""
echo "### All applications installed successfully ###"
echo ""
