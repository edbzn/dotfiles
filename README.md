# .dotfiles

<img src="./dotfiles-logo.png" width="300">

This repository provides all my dev tools and configurations.

## Setup

1. Clone this repository in home directory.

```sh
git clone git@github.com:edbzn/.dotfiles.git ~/.dotfiles
```

2. Install the tools. 

```sh
~/.dotfiles/scripts/install.sh
```

3. Configure using [GNU Stow](https://www.gnu.org/software/stow/).

```sh
stow git zsh terminator
```

## My tools 

- **Shell** : Zsh + [Oh My Zsh](https://ohmyz.sh/)
- **Terminal** : Terminator 
- **Language** : Node.js + Yarn + NPM + [n](https://github.com/tj/n)
- **Container** : Docker CE + Docker Compose
- **Versioning** : Git + [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- **Various** : cURL + htop + Vim + Stow