export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="bureau"

plugins=(
  git symfony2 composer docker node yarn
)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

export LANG=fr_FR.UTF-8

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# AR-Connect ENV_VARIABLES
export PROJECT_ENV=dev
export SYMFONY_ENV=dev
