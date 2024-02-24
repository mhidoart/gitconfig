#!/bin/bash

# Check if email parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <email>"
    exit 1
fi

email="$1"

# Generate SSH Key
ssh-keygen -t rsa -b 4096 -C "$email"

# Add SSH Key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Copy SSH Key to clipboard
if [ "$(uname)" == "Darwin" ]; then
    pbcopy < ~/.ssh/id_rsa.pub
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get install xclip -y
    xclip -sel clip < ~/.ssh/id_rsa.pub
fi

# Prompt user to add SSH Key to GitLab
echo "Your SSH key has been copied to the clipboard."
echo "Please add it to your GitLab account by pasting it in the SSH Keys section."
echo "Press Enter to continue..."
read -r
