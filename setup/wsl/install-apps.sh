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

# curl & wget & build-essential (needed by nvm / other installers)
sudo apt-get install -y curl build-essential wget gnupg lsb-release

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

# Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Docker Engine + Docker Compose
echo "Installing Docker Engine and Docker Compose..."
curl -fsSL https://get.docker.com | sh

echo ""
echo "### All applications installed successfully ###"
echo ""
