#!/bin/sh

# Alacritty
diff -I 'program:' roles/development/alacritty/templates/alacritty.yml.j2 ~/.alacritty.yml

# fish
diff roles/development/fish/templates/config.fish ~/.config/fish/config.fish
find roles/development/fish/templates/functions -type f | sed 's/roles\/development\/fish\/templates\/functions\///' | xargs -n1 -I{} sh -c "diff roles/development/fish/templates/functions/{} ~/.config/fish/functions/{}"

# git
diff roles/development/common/templates/gitconfig ~/.gitconfig

# Neovim
find roles/development/neovim/templates/config -type f | sed 's/roles\/development\/neovim\/templates\/config\///' | xargs -n1 -I{} sh -c "diff ~/.config/nvim/{} roles/development/neovim/templates/config/{}"

# tmux
diff -I '^set -g default-shell' roles/development/tmux/templates/tmux.conf.j2 ~/.tmux.conf
