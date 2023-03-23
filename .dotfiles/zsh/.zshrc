export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
UPDATE_ZSH_DAYS=7

plugins=(
  git
  docker-compose
  node
  npm
  nx-completion
  systemd
  sudo
  ssh-agent
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
alias nx-check="nx affected --target=lint,test,build --parallel=8"

source $ZSH/oh-my-zsh.sh
