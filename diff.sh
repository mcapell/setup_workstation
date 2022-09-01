#!/bin/sh

# Alacritty
diff -I 'program:' roles/development/alacritty/templates/alacritty.yml.j2 ~/.alacritty.yml

# fish
diff roles/development/fish/templates/config.fish.j2 ~/.config/fish/config.fish

# git
diff roles/development/common/templates/gitconfig ~/.gitconfig

# Neovim
find roles/development/neovim/templates/config -type f | sed 's/roles\/development\/neovim\/templates\/config\///' | xargs -n1 -I{} sh -c "diff roles/development/neovim/templates/config/{} ~/.config/nvim/{}"

# tmux
diff -I '^set -g default-shell' roles/development/tmux/templates/tmux.conf.j2 ~/.tmux.conf
