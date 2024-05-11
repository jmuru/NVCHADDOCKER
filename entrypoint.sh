#!/bin/sh

# Check if a directory argument is provided
if [ -n "$1" ]; then
  # If provided, change to that directory
  cd "$1" || exit
fi

# Start Neovim with the custom configuration
nvim 
