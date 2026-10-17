#!/usr/bin/env bash
# Pós-instalação do CachyOS. Rode como usuário normal (não root):
#   curl -fsSL https://raw.githubusercontent.com/EduardoBllc/my-utils/main/cachyos-pos-install.sh | bash
set -euo pipefail
[[ $EUID -eq 0 ]] && { echo "Rode sem sudo; o script pede a senha quando precisar."; exit 1; }

# Repositórios oficiais + CachyOS (pacman)
REPO=(
  git base-devel flatpak github-cli
  steam lutris wine winetricks goverlay prismlauncher
  timeshift pavucontrol-qt qemu-desktop
  docker docker-compose docker-buildx
)

# AUR (via paru)
AUR=(
  heroic-games-launcher-bin protonplus
  visual-studio-code-bin jetbrains-toolbox git-credential-manager-bin
  brave-bin helium-browser-bin webapp-manager
  ai-memory-bin
)

FLATPAK=(
  com.github.tchx84.Flatseal
  com.rtosta.zapzap
  com.spotify.Client
  io.github.kolunmi.Bazaar
)

sudo pacman -Syu --needed --noconfirm "${REPO[@]}" paru
paru -S --needed --noconfirm --skipreview "${AUR[@]}"   # sem prompts, para rodar via curl | bash

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub "${FLATPAK[@]}"

# Login do git pelo navegador, credenciais no keyring do desktop
git-credential-manager configure
git config --global credential.credentialStore secretservice

# Docker sem sudo (vale após relogar)
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Node via nvm (como no Nobara) + Claude Code
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"
nvm install --lts
curl -fsSL https://claude.ai/install.sh | bash

# ai-memory: serviço do usuário + hooks/MCP nos agentes (precisa rodar depois do Claude)
export PATH="$HOME/.local/bin:$PATH"
ai-memory setup --yes

# Plugins, skills e ferramentas do Claude Code
claude plugin marketplace add DietrichGebert/ponytail
claude plugin install ponytail@ponytail
claude plugin install superpowers@claude-plugins-official
npx -y skills add mattpocock/skills --skill grill-me --skill grilling -g -a claude-code -y   # grill-me chama a skill grilling
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
rtk init -g --auto-patch

echo "Pronto. Faça logout/login para o grupo docker valer."
