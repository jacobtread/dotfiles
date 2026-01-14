# Starship
eval "$(starship init zsh)"

# Node version switcher
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

# Command suggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# pnpm
export PNPM_HOME="${PNPM_HOME:-$HOME/Library/pnpm}"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# License helper alias
alias license="curl -LJ -o LICENSE.md https://jacobtread.com/licenses/MIT.md"

# Alias because I always use the shorthand that doesn't exist
alias cls="clear"

# "Zed now" open zed in the current folder
alias zn="zed ."

source $HOME/export-esp.sh

export BINDGEN_EXTRA_CLANG_ARGS="--target=arm64-apple-darwin --sysroot=$(xcrun --show-sdk-path)"
