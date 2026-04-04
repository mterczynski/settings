#!/usr/bin/env bash
# main.sh - Main setup script for WSL (Windows Subsystem for Linux)

# If invoked as `sh setup/wsl/main.sh`, re-run under bash so BASH_SOURCE works.
if [ -z "${BASH_VERSION:-}" ]; then
    exec bash "$0" "$@"
fi

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd)"
SETUP_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

# ─── 1. Install applications ─────────────────────────────────────────────────
echo "Running install-apps.sh..."
bash "$SCRIPT_DIR/install-apps.sh"

# ─── 2. Configure git ────────────────────────────────────────────────────────
echo "Running git-config.sh..."
bash "$SETUP_DIR/git-config.sh"

# ─── 3. Create a new SSH key ─────────────────────────────────────────────────
echo ""
echo "### Creating SSH key ###"
echo ""

SSH_KEY="$HOME/.ssh/id_ed25519"

if [ -f "$SSH_KEY" ]; then
    echo "SSH key already exists at $SSH_KEY — skipping creation."
else
    read -rp "Enter your email address for the SSH key: " ssh_email
    ssh-keygen -t ed25519 -C "$ssh_email" -f "$SSH_KEY" -N ""
    echo ""
    echo "SSH key created at $SSH_KEY"
    echo ""
    echo "Add the following public key to your GitHub account (Settings → SSH keys):"
    echo ""
    cat "${SSH_KEY}.pub"
    echo ""
    read -rp "Press Enter once you have added the key to GitHub to continue..."
fi

# Ensure ssh-agent is running and the key is loaded
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# ─── 4. Install Python dependencies ─────────────────────────────────────────
echo ""
echo "Installing Python dependencies..."
pip3 install -r "$SETUP_DIR/requirements.txt"

# ─── 5. Clone all public repositories ────────────────────────────────────────
echo ""
echo "Running clone-all.py..."
python3 "$SETUP_DIR/clone-all.py"

echo ""
echo "### All setup steps completed ###"
echo ""
