# arch-setup

Arch Linux dotfiles and package installer using the bare git repo method.
Configs are tracked directly in `$HOME` — no symlinks, no copies.

## Fresh Install

From a minimal Arch install with internet access:

```bash
sudo pacman -S git
curl -fsSLO https://raw.githubusercontent.com/nojuza/arch-setup/main/deploy.sh
bash deploy.sh
```

`deploy.sh` handles cloning the bare repo, checking out configs, and running the
package installer. If any local files conflict with the repo, it walks through
each one interactively so you can choose to replace, keep, or back up.

### Deploying to an existing system

Same command — `deploy.sh` detects existing files and prompts per-file:

- **(r)eplace** — overwrite local with repo version
- **(k)eep** — keep your local version
- **(b)ackup & replace** — save local to `~/.dotfiles-backup/<timestamp>/`, then overwrite

Backed-up files are preserved so you can review or restore them later.

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
