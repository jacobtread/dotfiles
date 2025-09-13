#!/bin/bash
DOTFILES="$HOME/dotfiles"

# Ensure ~/.gitconfig exists
touch "$HOME/.gitconfig"

# Check if the include line already exists
if ! git config --global --get include.path | grep -q "$DOTFILES/.gitconfig"; then
    git config --global include.path "$DOTFILES/.gitconfig"
    echo "Added include.path to ~/.gitconfig"
else
    echo "include.path already set in ~/.gitconfig"
fi

# Optional: symlink Zsh config
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

# Add sourcing line to the top of ~/.zshrc to load the dotfiles version if not already present
ZSHRC="$HOME/.zshrc"
SOURCE_LINE="[ -r \"$DOTFILES/zsh/.zshrc\" ] && source \"$DOTFILES/zsh/.zshrc\""

if ! grep -Fxq "$SOURCE_LINE" "$ZSHRC"; then
    # Insert at the top
    sed -i.bak "1i $SOURCE_LINE" "$ZSHRC"
    echo "Added dotfiles sourcing line to ~/.zshrc (backup at ~/.zshrc.bak)"
else
    echo "Dotfiles sourcing line already present in ~/.zshrc"
fi
