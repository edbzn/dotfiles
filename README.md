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

2. Update tools, note that tags are optional, if not passed it will update everything.

```sh
~/dotfiles/update.sh docker node dotfiles chrome
```

## Force Reinstall

Sometimes you may want to force reinstall everything regardless of current state (e.g., to fix corrupted installations or reset configurations). The force install feature provides robust reinstallation capabilities with dry-run support and granular control.

### Quick Start
```sh
# Force install everything
~/dotfiles/force-install.sh

# Force install specific roles
~/dotfiles/force-install.sh --tags zsh,docker,node

# Test what would be changed (dry-run)
~/dotfiles/force-install.sh --check
```

### Advanced Usage
```sh
# Force install with confirmation prompt
~/dotfiles/force-install.sh --ask-become-pass

# Force install with detailed diff output
~/dotfiles/force-install.sh --check --diff --tags docker

# Verbose output for debugging
~/dotfiles/force-install.sh --verbose --tags slack
```

For comprehensive documentation, see [FORCE_INSTALL.md](./FORCE_INSTALL.md).

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
