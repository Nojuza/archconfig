#!/usr/bin/env bash
# ============================================================
#  Arch Linux Setup Script — nojuza
#
#  Prerequisites: dotfiles already checked out via bare repo.
#    git clone --bare <repo-url> $HOME/.dotfiles
#    alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
#    dotfiles checkout
#
#  This script installs packages from ~/.config/packages.conf,
#  enables services, and configures the user environment.
#  Run as your normal user (NOT root).
# ============================================================

set -euo pipefail

PACKAGES_FILE="$HOME/.config/packages.conf"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${CYAN}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[ OK ]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERR ]${NC} $1"; exit 1; }

# --- Preflight checks ---

if [[ $EUID -eq 0 ]]; then
    error "Do not run this script as root. Run as your normal user."
fi

if [[ ! -f "$PACKAGES_FILE" ]]; then
    error "packages.conf not found at $PACKAGES_FILE — did you run 'dotfiles checkout' first?"
fi

# --- Parse packages.conf ---

mapfile -t PACKAGES < <(
    sed 's/#.*//; s/^[[:space:]]*//; s/[[:space:]]*$//' "$PACKAGES_FILE" | sed '/^$/d'
)

info "Found ${#PACKAGES[@]} packages in packages.conf"

# --- Bootstrap yay if not installed ---

if ! command -v yay &>/dev/null; then
    info "yay not found — bootstrapping from AUR..."
    sudo pacman -S --needed --noconfirm base-devel git
    YAY_TMP=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    (cd "$YAY_TMP/yay" && makepkg -si --noconfirm)
    rm -rf "$YAY_TMP"
    ok "yay installed"
else
    ok "yay already installed"
fi

# --- Install packages ---

info "Installing packages (this may take a while)..."
echo ""

yay -S --needed --noconfirm --combinedupgrade "${PACKAGES[@]}"

ok "All packages installed"

# --- Deploy device-specific configs ---

MONITOR_CONF="$HOME/.config/hypr/conf/monitor.conf"
MONITOR_DEFAULT="$HOME/.config/hypr/conf/monitor.conf.default"
if [[ ! -f "$MONITOR_CONF" ]] && [[ -f "$MONITOR_DEFAULT" ]]; then
    cp "$MONITOR_DEFAULT" "$MONITOR_CONF"
    ok "Deployed default monitor.conf — edit it for this device's displays"
else
    ok "monitor.conf already exists, skipping"
fi

# --- Deploy Firefox profile config ---
# Firefox stores profiles in random-named dirs, so we find the active one
# and copy our chrome/ and user.js into it.

info "Deploying Firefox Cyberpunk theme..."
FF_CONFIG="$HOME/.config/firefox"
if [[ -d "$FF_CONFIG/chrome" ]]; then
    # Find the default-release profile (or first profile dir)
    FF_PROFILE=$(find "$HOME/.mozilla/firefox" -maxdepth 1 -name "*.default-release" -type d 2>/dev/null | head -1)
    if [[ -z "$FF_PROFILE" ]]; then
        # Fallback: launch Firefox once to create a profile, or find any profile
        FF_PROFILE=$(find "$HOME/.mozilla/firefox" -maxdepth 1 -name "*.default" -type d 2>/dev/null | head -1)
    fi
    if [[ -n "$FF_PROFILE" ]]; then
        mkdir -p "$FF_PROFILE/chrome"
        cp "$FF_CONFIG/chrome/userChrome.css" "$FF_PROFILE/chrome/"
        cp "$FF_CONFIG/chrome/userContent.css" "$FF_PROFILE/chrome/"
        cp "$FF_CONFIG/user.js" "$FF_PROFILE/"
        ok "Firefox theme deployed to $FF_PROFILE"
    else
        warn "No Firefox profile found — launch Firefox once, then re-run this script"
    fi
else
    warn "No Firefox config found in $FF_CONFIG, skipping"
fi

# --- Hide untracked files in dotfiles repo ---

info "Configuring dotfiles repo..."
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no
ok "Dotfiles repo configured (untracked files hidden)"

# --- Enable key services ---

info "Enabling system services..."

declare -a SERVICES=(
    "sddm"
    "NetworkManager"
    "docker"
    "tailscaled"
    "bluetooth"
)

for svc in "${SERVICES[@]}"; do
    if systemctl list-unit-files "$svc.service" &>/dev/null; then
        sudo systemctl enable --now "$svc.service" 2>/dev/null && ok "Enabled $svc" || warn "$svc already enabled or unavailable"
    else
        warn "Service $svc not found, skipping"
    fi
done

# --- Add user to required groups ---

info "Adding $USER to docker group..."
sudo usermod -aG docker "$USER" 2>/dev/null && ok "Added to docker group" || warn "Already in docker group"

# --- Set default shell to bash ---

if [[ "$SHELL" != */bash ]]; then
    info "Setting default shell to bash..."
    chsh -s "$(which bash)"
    ok "Default shell set to bash"
else
    ok "Shell already set to bash"
fi

echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  Setup complete!${NC}"
echo -e "${GREEN}  Log out and back in for group changes to take effect.${NC}"
echo -e "${GREEN}                                                            ${NC}"
echo -e "${GREEN}  Manage your dotfiles with the 'dotfiles' command:${NC}"
echo -e "${GREEN}    dotfiles status          # see changed configs${NC}"
echo -e "${GREEN}    dotfiles add -u          # stage all tracked changes${NC}"
echo -e "${GREEN}    dotfiles commit -m \"msg\" # commit${NC}"
echo -e "${GREEN}    dotfiles push            # push to GitHub${NC}"
echo -e "${GREEN}    dotfiles add -f <file>   # track a new file${NC}"
echo -e "${GREEN}============================================================${NC}"
