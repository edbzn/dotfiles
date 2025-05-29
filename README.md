<img src="./.assets/dotfiles-logo.png" width="300" alt="dotfiles">

This repository provides my ready-to-use dev environment in seconds using [Ansible](https://www.ansible.com
) and [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

1. Clone the repository in the home directory.

```sh
git clone git@github.com:edbzn/dotfiles.git ~/dotfiles
```

2. Install and configure the tools.

```sh
~/dotfiles/install.sh
```

## Update

1. List available tags.

```sh
~/dotfiles/tags.sh
```

2. Update tools with complete reinstallation. The update script reinstalls everything regardless of current state to ensure a clean environment. Tags are optional - if not passed it will update everything.

```sh
# Update everything
~/dotfiles/update.sh

# Update specific roles
~/dotfiles/update.sh --tags docker,node,dotfiles,chrome

# Test what would be changed (dry-run)
~/dotfiles/update.sh --check

# Update with confirmation prompt
~/dotfiles/update.sh --ask-become-pass

# Update with detailed diff output
~/dotfiles/update.sh --check --diff --tags docker

# Verbose output for debugging
~/dotfiles/update.sh --verbose --tags slack
```

For comprehensive documentation, see [UPDATE_FEATURES.md](./UPDATE_FEATURES.md).

## Tools

- **Shell** : Zsh + [Oh My Zsh](https://ohmyz.sh/) + Powerlevel10k
- **Terminal** : Terminator
- **JavaScript Runtime** : Node.js + Bun + NPM + Corepack + [n](https://github.com/tj/n)
- **Rust** : Rust + Cargo
- **Global Packages** : Nx + @angular/cli + http-server
- **Containers** : Docker CE + Docker Compose
- **Versioning** : Git + [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- **Editors** : Visual Studio Code + Vim
- **Browser** : Google Chrome
- **Collaboration** : Slack
- **Programming Font** : [JetBrains Mono](https://www.jetbrains.com/fr-fr/lp/mono/) + [JetBrainsMono Nerd](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono)
- **Various Tools** : cURL + htop + [GNU Stow](https://www.gnu.org/software/stow/) + [Flameshot](https://flameshot.org/) + jq + gnome-tweaks + gh + lsd
