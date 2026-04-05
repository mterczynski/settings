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

# GitHub CLI (gh)
echo "Installing GitHub CLI..."
sudo apt-get install -y gh

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

# Docker Engine + Docker Compose plugin
echo "Installing Docker Engine and Docker Compose..."

# Prerequisites
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# shellcheck source=/dev/null
. /etc/os-release

# Add Docker's official GPG key (idempotent)
sudo install -m 0755 -d /etc/apt/keyrings
if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
    curl -fsSL "https://download.docker.com/linux/${ID}/gpg" \
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker apt repository (idempotent)
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
fi

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Allow running Docker without sudo (takes effect on next login)
if sudo usermod -aG docker "$USER"; then
    echo "Added $USER to the docker group — please log out and back in for this to take effect."
else
    echo "Warning: could not add $USER to the docker group. You may need to run Docker commands with sudo."
fi

echo ""
echo "### All applications installed successfully ###"
echo ""
