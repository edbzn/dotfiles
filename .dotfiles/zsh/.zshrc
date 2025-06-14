# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
UPDATE_ZSH_DAYS=7

plugins=(
  git
  docker-compose
  node
  npm
  nx-completion
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  systemd
  sudo
  ssh-agent
  you-should-use
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load Rust environment.
[ -f ~/.cargo/env ] && source ~/.cargo/env

# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias ls="lsd"
alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias work="cd ~/work"
alias nx-check="nx affected --target=lint,test,build --parallel=8"

# Rosa
export AWS_REGION=eu-central-1
export AWS_PROFILE=rosa-dev

