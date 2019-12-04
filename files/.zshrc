export ZSH=/home/edouard/.oh-my-zsh

ZSH_THEME="bureau"
UPDATE_ZSH_DAYS=1

plugins=(
  git symfony2 composer docker node yarn npm systemd web-search
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Start ssh-agent automatically and make sure that only one process runs at a time
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias work="cd ~/work"

source $ZSH/oh-my-zsh.sh
