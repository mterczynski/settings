#!/bin/bash
# install-apps.sh - Install developer tools and applications for WSL (Windows Subsystem for Linux)
# Note: GUI applications (VS Code, Brave, Discord, Telegram, Signal, OBS Studio, Blender, etc.)
# should be installed on the Windows side, not inside WSL.

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

# JDK (default for the current Ubuntu release)
echo "Installing default JDK..."
sudo apt-get install -y default-jdk

# curl & build-essential (needed by nvm / other installers)
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

# ─── General Applications ────────────────────────────────────────────────────

echo ""
echo "### Installing General Applications ###"
echo ""

# PostgreSQL
echo "Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib

echo ""
echo "### All applications installed successfully ###"
echo ""
