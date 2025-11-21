# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add local bin to PATH for zoxide and other local binaries
export PATH="$HOME/.local/bin:$PATH"

export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
UPDATE_ZSH_DAYS=7

plugins=(
  git
  node
  nx-completion
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
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

# Aliases with conditional checks
if command -v lsd &> /dev/null; then
  alias ls="lsd"
fi

if command -v batcat &> /dev/null; then
  alias cat="batcat"
elif command -v bat &> /dev/null; then
  alias cat="bat"
fi

if command -v fzf &> /dev/null; then
  alias find="fzf"
fi

if command -v rg &> /dev/null; then
  alias grep="rg"
fi

alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias work="cd ~/work"
alias nx-check="nx affected --target=lint,test,build --parallel=8"

# Initialize zoxide and alias cd to it
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# Initialize fzf
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# Rosa
export AWS_REGION=eu-central-1
export AWS_PROFILE=rosa-dev

# Source machine-specific configuration (GPG, secrets, etc.)
# This file is not tracked in git
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
