export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="bureau"

plugins=(
  git symfony2 composer docker node yarn
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source $ZSH/oh-my-zsh.sh

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias work="cd ~/work"

UPDATE_ZSH_DAYS=7
DISABLE_AUTO_UPDATE="true"

# Env language
export LANG=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH

# AR-Connect ENV_VARIABLES
export PROJECT_ENV=dev
export SYMFONY_ENV=dev

# Run kwallet at bootstrap to store ssh key
export SSH_ASKPASS=ksshaskpass 

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
