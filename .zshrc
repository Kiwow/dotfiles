# neovim
alias vim=nvim
export EDITOR=nvim
export PATH=/Users/matyasvolf/bin/nvim-macos-arm64/bin:$PATH

# git aliases
alias gst="git status"
alias ga="git add"
alias gap="git add -p"
alias gfe="git fetch"
alias gll="git log --oneline --graph --all"
alias gsh="git show --stat"
alias gco="git commit"
alias gsw="git switch"
alias gbr="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias gre="git restore"
alias gres="git restore --staged"
alias grb='git rebase $(git symbolic-ref refs/remotes/origin/HEAD --short)'

# bat
export BAT_THEME="Catppuccin Mocha"

# aliases
alias clr=clear
alias ls="eza --color=automatic --group-directories-first --icons=never"
alias cat=bat

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# starship
eval "$(starship init zsh)"
