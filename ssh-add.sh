#!/usr/bin/env bash

# Variables
REMOTE_USER=""        # Replace with the remote server username
REMOTE_HOST=""        # Replace with the remote server address
SSH_KEY_PATH="$HOME/.ssh/id_ed25519.pub"  # Path to your SSH public key

# Check if the SSH public key file exists
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "Error: SSH public key not found at $SSH_KEY_PATH"
  exit 1
fi

# Copy the SSH public key to the remote server
echo "Adding SSH key to remote server..."
ssh-copy-id -i "$SSH_KEY_PATH" "$REMOTE_USER@$REMOTE_HOST"

# Verify if the key was added successfully
if [ $? -eq 0 ]; then
  echo "SSH key successfully added to $REMOTE_HOST"
else
  echo "Failed to add SSH key to $REMOTE_HOST"
  exit 1
fi
