#!/bin/bash

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check if installation was successful
if [ $? -eq 0 ]; then
  echo "Oh My Zsh installed successfully!"

  # Prompt for theme selection
  echo "Available themes:"
  ls ~/.oh-my-zsh/themes | grep -v ^README.md

  read -p "Enter the name of the theme you want to use: " theme_name

  # Update .zshrc with the selected theme
  sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"$theme_name\"/" ~/.zshrc

  echo "Theme updated! Restart your terminal to see the changes."
else
  echo "Oh My Zsh installation failed. Please check the error messages and try again."
fi
