export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="bureau"
UPDATE_ZSH_DAYS=7

plugins=(
  git 
  pyenv 
  docker-compose 
  node 
  yarn 
  yarn-completion 
  npm 
  ng
  systemd 
  web-search 
  gatsby 
  vscode 
  sudo 
  ssh-agent 
  heroku
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias work="cd ~/work"

source $ZSH/oh-my-zsh.sh
