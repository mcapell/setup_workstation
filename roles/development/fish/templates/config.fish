if status is-interactive
    # Commands to run in interactive sessions can go here
end

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✗"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# Set standard language and localization
export LC_ALL=C.UTF-8

export EDITOR="nvim"
export GOBIN="$HOME/.local/bin"
export GOPRIVATE=github.com/docker
export PATH="/opt/homebrew/bin:$GOBIN:$HOME/.cargo/bin:$HOME/bin:$PATH"
export TERM="screen-256color"

export NVM_DIR="$HOME/.nvm"

# Tools
alias m="tmuxinator"
alias t="task"
alias dw="docker workflow"

# Random aliases
alias vim="nvim"
alias emacs="nvim"
alias gs="git status -s"
alias gss="git status | grep -v vendor/"
alias ll="ls -al"
alias grep='grep --color=auto'
alias ping='ping -c 5'
alias rm='rm -i'

# Tools
alias languagetool='docker run -d -p 8081:8010 --name languagetool --restart=unless-stopped erikvl87/languagetool'

# Mimic pbcopy from OSX
# alias pbcopy='xclip -selection clipboard'

# Other infra aliases
alias eks='infra-cli aws configEks'

function fish_prompt
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)

    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    if [ $PWD != $HOME ]
        set_color yellow
        echo -n (prompt_pwd)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    echo -n (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    set_color normal
    echo -n '$ '
end

function fish_greeting
    task

    set_color normal
end
