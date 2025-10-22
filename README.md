<img src="./.assets/dotfiles-logo.png" width="300" alt="dotfiles">

[![CI](https://github.com/edbzn/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/edbzn/dotfiles/actions/workflows/ci.yml)

This repository provides a ready-to-use dev environment using [Ansible](https://www.ansible.com) and [GNU Stow](https://www.gnu.org/software/stow/). It installs, configures, and synchronizes all your essential developer tools, dotfiles, and secrets — enabling you to spin up a complete, personalized workspace on any machine in seconds.

## 🚀 Setup

1. Clone the repository in the home directory.

```sh
git clone git@github.com:edbzn/dotfiles.git ~/dotfiles
```

2. Install and configure the tools. (idempotent — safe to re-run anytime):

```sh
~/dotfiles/install.sh
```

> 💡 **Idempotent Installation**: The setup process is designed to be completely safe to run multiple times. Whether you are setting up a fresh system or updating an existing one, the scripts will intelligently detect what's already installed and only make necessary changes.

## 🔄 Update

### List Available Components

```sh
~/dotfiles/tags.sh
```

### Update Tools

The update script provides **idempotent updates** - it only installs missing tools and updates outdated ones. For a complete reinstallation, use the `--force-install` flag.

```sh
# Update everything (idempotent - only installs what's missing)
~/dotfiles/update.sh

# Update specific roles
~/dotfiles/update.sh docker,node,dotfiles

# Or use --tags explicitly
~/dotfiles/update.sh --tags zsh,chrome

# Force reinstall everything regardless of current state
~/dotfiles/update.sh --force-install

# Force reinstall specific roles
~/dotfiles/update.sh --force-install --tags docker,node

# Test what would be changed (dry-run)
~/dotfiles/update.sh --check

# Update with detailed diff output
~/dotfiles/update.sh --check --diff --tags docker

# Verbose output for debugging
~/dotfiles/update.sh --verbose --tags slack
```

**Options:**
- `--force-install` - Force reinstall everything regardless of current state
- `--check` - Run in dry-run mode without making changes
- `--diff` - Show differences when making changes
- `--verbose` - Enable verbose output
- `--tags <tags>` - Update only specific roles (comma-separated)

## 🧠 Shell History Backup

Easily preserve your command history across machines — **encrypted** and **secret-filtered**.

```sh
# Run the backup script and choose option 3 or 4
~/dotfiles/backup-secrets.sh

# Commit encrypted history
git add secrets/
git commit -m "Add encrypted shell history"
```

## 🔐 Secrets Management

Securely sync your SSH and GPG keys across machines using **Ansible Vault** encryption.

### Initial Setup

```sh
# 1. Create vault password (one-time setup)
echo "your-secure-password" > ~/dotfiles/.vault_password
chmod 600 ~/dotfiles/.vault_password

# 2. Backup and encrypt your keys
~/dotfiles/backup-secrets.sh

# 3. Commit encrypted keys
git add secrets/
git commit -m "Add encrypted SSH, GPG keys, and shell history"
git push
```

### On New Machines

```sh
# 1. Create the same vault password
echo "your-secure-password" > ~/dotfiles/.vault_password
chmod 600 ~/dotfiles/.vault_password

# 2. Run install - your keys are automatically restored!
~/dotfiles/install.sh
```

📖 **Full Documentation**: See [docs/SECRETS.md](docs/SECRETS.md) for complete guide, manual operations, and troubleshooting.

**What's Encrypted:**
- SSH private and public keys
- GPG private keys
- Shell history (with automatic secret filtering)
- Safe to commit - only you have the password! 🔒

## ⚙️ Tools Overview

The following tools are automatically installed and configured:

| Category            | Tool                                                                 | Logo                                                                                                                                                           | Description                                      |
| ------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| **Shell**           | [Zsh](https://zsh.sourceforge.io/) + [Oh My Zsh](https://ohmyz.sh/)  | <img src="https://ohmyz.sh/img/ohmyzsh-logo-ansi.png" width="24" alt="Zsh">                                                                                    | Enhanced shell with powerful features and themes |
| **Shell Theme**     | [Powerlevel10k](https://github.com/romkatv/powerlevel10k)            | <img src="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/prompt-styles-high-contrast.png" width="24" alt="P10k">                         | Fast and customizable prompt theme               |
| **Terminal**        | [Terminator](https://gnome-terminator.org/)                          | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Gnome-Terminator.svg/1200px-Gnome-Terminator.svg.png" width="24" alt="Terminator">         | Advanced terminal emulator with multiple panes   |
| **JavaScript**      | [Node.js](https://nodejs.org/)                                       | <img src="https://cdn-icons-png.flaticon.com/512/5968/5968322.png" width="24" alt="Node.js">                                                                   | JavaScript runtime built on Chrome's V8 engine   |
| **JavaScript**      | [Bun](https://bun.sh/)                                               | <img src="https://bun.sh/logo-square.png" width="24" alt="Bun">                                                                                                | Fast all-in-one JavaScript runtime & toolkit     |
| **Package Manager** | [NPM](https://www.npmjs.com/)                                        | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Npm-logo.svg/2560px-Npm-logo.svg.png" width="24" alt="npm">                                | Package manager for JavaScript                   |
| **Node Version**    | [n](https://github.com/tj/n)                                         | 🔢                                                                                                                                                             | Simple Node.js version management                |
| **Systems**         | [Rust](https://www.rust-lang.org/) + [Cargo](https://crates.io/)     | <img src="https://www.rust-lang.org/static/images/favicon-32x32.png" width="24" alt="Rust">                                                                    | Systems programming language with memory safety  |
| **Build Tools**     | [Nx](https://nx.dev/)                                                | <img src="https://miro.medium.com/v2/resize:fit:1048/0*8tu6dgB0zeyiz-vo.png" width="24" alt="Nx">                                                              | Smart monorepos build system                     |
| **Framework**       | [@angular/cli](https://angular.io/cli)                               | <img src="https://angular.io/assets/images/favicons/favicon-32x32.png" width="24" alt="Angular">                                                               | Angular development CLI                          |
| **Development**     | [http-server](https://github.com/http-party/http-server)             | 🌐                                                                                                                                                             | Simple HTTP server for development               |
| **Containers**      | [Docker CE](https://www.docker.com/)                                 | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker">                                                       | Container platform for applications              |
| **Containers**      | [Docker Compose](https://docs.docker.com/compose/)                   | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker">                                                       | Multi-container Docker applications              |
| **Version Control** | [Git](https://git-scm.com/)                                          | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Git_icon.svg/2048px-Git_icon.svg.png" width="24" alt="Git">                              | Distributed version control system               |
| **Git Enhancement** | [delta](https://github.com/dandavison/delta)                         | ✨                                                                                                                                                             | A syntax-highlighting pager for Git              |
| **Git CLI**         | [GitHub CLI](https://cli.github.com/)                                | <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="24" alt="GitHub">                                                  | GitHub operations from command line              |
| **Editor**          | [Visual Studio Code](https://code.visualstudio.com/)                 | <img src="https://code.visualstudio.com/favicon.ico" width="24" alt="VS Code">                                                                                 | Lightweight yet powerful code editor             |
| **Editor**          | [Vim](https://www.vim.org/)                                          | <img src="https://www.vim.org/images/vim_header.gif" width="24" alt="Vim">                                                                                     | Highly configurable text editor                  |
| **Browser**         | [Google Chrome](https://www.google.com/chrome/)                      | <img src="https://www.google.com/chrome/static/images/favicons/favicon-32x32.png" width="24" alt="Chrome">                                                     | Modern web browser                               |
| **Communication**   | [Slack](https://slack.com/)                                          | <img src="https://slack.com/favicon.ico" width="24" alt="Slack">                                                                                               | Team collaboration platform                      |
| **Font**            | [JetBrains Mono](https://www.jetbrains.com/lp/mono/)                 | <img src="https://www.jetbrains.com/favicon-32x32.png" width="24" alt="JetBrains">                                                                             | Programming font with ligatures                  |
| **Font**            | [JetBrains Mono Nerd](https://www.nerdfonts.com/)                    | <img src="https://www.nerdfonts.com/assets/img/nerd-fonts-logo.png" width="24" alt="Nerd Fonts">                                                               | Programming font with extra glyphs               |
| **Network**         | [cURL](https://curl.se/)                                             | <img src="https://curl.se/logo/curl-symbol.png" width="24" alt="cURL">                                                                                         | Command line tool for transferring data          |
| **System**          | [htop](https://htop.dev/)                                            | 📊                                                                                                                                                             | Interactive process viewer                       |
| **System**          | [btop](https://github.com/aristocratos/btop)                         | <img src="https://github.com/aristocratos/btop/raw/main/Img/logo.png" width="24" alt="btop">                                                                   | Resource monitor with modern UI                  |
| **Files**           | [GNU Stow](https://www.gnu.org/software/stow/)                       | 📁                                                                                                                                                             | Symlink farm manager for dotfiles                |
| **Screenshots**     | [Flameshot](https://flameshot.org/)                                  | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flameshot_logo.svg/96px-Flameshot_logo.svg.png?20210313192516" width="24" alt="Flameshot"> | Powerful screenshot tool                         |
| **JSON**            | [jq](https://stedolan.github.io/jq/)                                 | 🔧                                                                                                                                                             | Lightweight command-line JSON processor          |
| **System**          | [gnome-tweaks](https://wiki.gnome.org/Apps/Tweaks)                   | ⚙️                                                                                                                                                             | Advanced GNOME configuration tool                |
| **Files**           | [lsd](https://github.com/Peltoche/lsd)                               | 📂                                                                                                                                                             | Modern `ls` command with colors and icons        |
| **Music**           | [Spotify](https://www.spotify.com/)                                  | <img src="https://open.spotifycdn.com/cdn/images/favicon32.b64ecc03.png" width="24" alt="Spotify">                                                             | Music streaming platform                         |
| **Streaming**       | [OBS Studio](https://obsproject.com/)                                | <img src="https://obsproject.com/assets/images/new_icon_small-r.png" width="24" alt="OBS">                                                                     | Live streaming and screen recording              |
| **Gaming**          | [Steam](https://store.steampowered.com/)                             | <img src="https://store.steampowered.com/favicon.ico" width="24" alt="Steam">                                                                                  | Gaming platform and digital distribution         |
| **Communication**   | [Discord](https://discord.com/)                                      | <img src="https://upload.wikimedia.org/wikipedia/fr/thumb/4/4f/Discord_Logo_sans_texte.svg/1818px-Discord_Logo_sans_texte.svg.png" width="24" alt="Discord">                                                           | Voice, video and text communication              |
| **Infrastructure**  | [Terraform](https://www.terraform.io/)                               | <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_3yP8N1mLoNDdo2gkMzRQfwMpw3ZjiGZeoQ&s" width="24" alt="Terraform">                             | Infrastructure as Code tool                      |
| **Cloud**           | [AWS CLI](https://aws.amazon.com/cli/)                               | <img src="https://aws.amazon.com/favicon.ico" width="24" alt="AWS">                                                                                            | Amazon Web Services command line interface       |
| **AI**              | [Claude CLI](https://www.anthropic.com/claude)                       | <img src="https://www.anthropic.com/images/icons/apple-touch-icon.png" width="24" alt="Claude">                                                                | Anthropic Claude AI assistant CLI                |
| **Graphics**        | [GIMP](https://www.gimp.org/)                                        | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/The_GIMP_icon_-_gnome.svg/1024px-The_GIMP_icon_-_gnome.svg.png" width="24" alt="GIMP">     | GNU Image Manipulation Program                   |
| **Database**        | [MongoDB Compass](https://www.mongodb.com/products/compass)          | <img src="https://www.mongodb.com/assets/images/global/favicon.ico" width="24" alt="MongoDB">                                                                  | GUI for MongoDB database                         |
| **Database**        | [MongoDB CLI (mongosh)](https://www.mongodb.com/docs/mongodb-shell/) | <img src="https://www.mongodb.com/assets/images/global/favicon.ico" width="24" alt="MongoDB">                                                                  | MongoDB command line interface                   |
| **Python**          | [UV](https://github.com/astral-sh/uv)                                | <img src="https://miro.medium.com/v2/resize:fit:1400/1*eSnM1h_RX2tgE10fyE3w4Q.png" width="24" alt="UV">                                                        | Ultra-fast Python package and project manager    |
| **Video**           | [Zoom](https://zoom.us/)                                             | <img src="https://zoom.us/favicon.ico" width="24" alt="Zoom">                                                                                                  | Video conferencing platform                      |
