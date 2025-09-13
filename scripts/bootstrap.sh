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

# Add sourcing line to the top of ~/.zshrc to load the dotfiles version if not already present
ZSHRC="$HOME/.zshrc"
SOURCE_LINE="[ -r \"$DOTFILES/.zshrc\" ] && source \"$DOTFILES/.zshrc\""

# Ensure the file exists
if [ ! -e "$ZSHRC" ]; then
    touch "$ZSHRC"
fi

# Add the source line if it’s not already present
if ! grep -Fxq "$SOURCE_LINE" "$ZSHRC"; then
    printf "%s\n%s\n" "$SOURCE_LINE" "$(cat "$ZSHRC")" > "$ZSHRC"
    echo "Added dotfiles sourcing line to $ZSHRC"
else
    echo "Dotfiles sourcing line already present in $ZSHRC"
fi

ZED_CONFIG="$HOME/.config/zed/settings.json"

if [ -e "$ZED_CONFIG" ] && [ ! -L "$ZED_CONFIG" ]; then
    mv "$ZED_CONFIG" "${ZED_CONFIG}.bak"
    echo "Existing Zed config backed up to ${ZED_CONFIG}.bak"
fi

ln -sf "$DOTFILES/zed/settings.json" "$ZED_CONFIG"
echo "Zed config symlinked to $ZED_CONFIG"

ZED_KEYMAP="$HOME/.config/zed/keymap.json"

if [ -e "$ZED_KEYMAP" ] && [ ! -L "$ZED_KEYMAP" ]; then
    mv "$ZED_KEYMAP" "${ZED_KEYMAP}.bak"
    echo "Existing Zed keymap backed up to ${ZED_KEYMAP}.bak"
fi

ln -sf "$DOTFILES/zed/keymap.macos.json" "$ZED_KEYMAP"
echo "Zed keymap symlinked to $ZED_KEYMAP"
