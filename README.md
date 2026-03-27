# arch-setup

Arch Linux dotfiles and package installer using the bare git repo method.
Configs are tracked directly in `$HOME` — no symlinks, no copies.

## Fresh Install

From a minimal Arch install with internet access:

```bash
# 1. Install git
sudo pacman -S git

# 2. Clone as a bare repo
git clone --bare https://github.com/nojuza/arch-setup.git $HOME/.dotfiles

# 3. Define the alias for this session
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 4. Checkout files into $HOME (your configs land in place)
dotfiles checkout

# 5. If checkout fails due to existing files (e.g. default .bashrc):
#    dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | xargs -d '\n' rm
#    dotfiles checkout

# 6. Run the installer (packages, services, shell)
bash ~/install.sh
```

## Daily Usage

The `dotfiles` alias (loaded from `.zshrc`) replaces `git` for dotfile management:

```bash
# Check what changed
dotfiles status
dotfiles diff

# Commit changes to tracked files
dotfiles add -u
dotfiles commit -m "update hyprland keybinds"
dotfiles push

# Start tracking a new config file
dotfiles add -f ~/.config/newapp/config.toml
dotfiles commit -m "add newapp config"
dotfiles push
```

Only files you've explicitly added are tracked. Everything else in `$HOME` is ignored.
