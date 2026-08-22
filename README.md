# dotfiles

Personal macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each top-level directory (`zsh/`, `tmux/`, `git/`, `ssh/`) mirrors `$HOME` and gets symlinked into place.

## Structure

| Path                | Contents                                               |
| ------------------- | ------------------------------------------------------ |
| `Brewfile`          | All Homebrew formulae, casks, VS Code extensions, etc. |
| `zsh/`              | `.zshrc` (Oh My Zsh config, PATH, aliases)             |
| `tmux/`             | `.tmux.conf`                                           |
| `git/`              | Git config                                             |
| `ssh/`              | SSH config (no keys!)                                  |
| `nvim/`             | Neovim config (`~/.config/nvim`)                       |
| `claude/`           | Claude agent config (`~/.claude`)                      |
| `macos/defaults.sh` | macOS system preferences (`defaults write …`)          |
| `macos/non-brew.sh` | Tools not managed by Homebrew (idempotent)             |

## Restore on a new machine

```bash
# 1. Xcode Command Line Tools (provides git)
xcode-select --install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. Clone this repo (use https:// until SSH keys are restored)
git clone git@github.com:matinzd/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 4. Install everything from the Brewfile (includes stow itself)
brew bundle install

# 5. Symlink dotfiles into $HOME
stow -t ~ zsh tmux git ssh nvim claude

# 6. Non-brew tools (oh-my-zsh, nvm, sdkman, rustup, flutter, maestro, uv, …)
./macos/non-brew.sh

# 7. macOS system preferences
./macos/defaults.sh
```

### Notes

- **Order matters** — run `stow` _before_ `non-brew.sh`: the Oh My Zsh installer runs with `--keep-zshrc` so it won't overwrite the stowed `.zshrc`.
- **Stow conflicts** — if a default file (e.g. `~/.zshrc`) already exists, stow refuses to link. Force this repo's version to win with:
  ```bash
  stow --adopt -t ~ zsh && git checkout .
  ```
- **SSH keys** — restore private keys from 1Password before cloning over SSH, or clone via HTTPS first. Keys are never stored in this repo.
- Some `defaults.sh` settings need a logout/restart to take effect.
