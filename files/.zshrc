export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="bureau"
UPDATE_ZSH_DAYS=1

plugins=(
  git symfony2 composer docker docker-compose node yarn yarn-completion npm nvm systemd web-search gatsby golang vscode systemd sudo ssh-agent heroku ansible
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias work="cd ~/work"

source $ZSH/oh-my-zsh.sh
