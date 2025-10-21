<img src="./.assets/dotfiles-logo.png" width="300" alt="dotfiles">

This repository provides my ready-to-use dev environment in seconds using [Ansible](https://www.ansible.com) and [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

1. Clone the repository in the home directory.

```sh
git clone git@github.com:edbzn/dotfiles.git ~/dotfiles
```

2. Install and configure the tools. The installation is **idempotent** - you can run it multiple times safely without any side effects. It will only install missing tools and skip existing ones.

```sh
~/dotfiles/install.sh
```

> 💡 **Idempotent Installation**: The setup process is designed to be completely safe to run multiple times. Whether you're setting up a fresh system or updating an existing one, the scripts will intelligently detect what's already installed and only make necessary changes.

## Update

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

## Tools

The following tools are automatically installed and configured:

| Category            | Tool                                                                 | Logo                                                                                                                                                           | Description                                      | Documentation                                              |
| ------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ---------------------------------------------------------- |
| **Shell**           | [Zsh](https://zsh.sourceforge.io/) + [Oh My Zsh](https://ohmyz.sh/)  | <img src="https://ohmyz.sh/img/ohmyzsh-logo-ansi.png" width="24" alt="Zsh">                                                                                    | Enhanced shell with powerful features and themes | [zsh.org](https://zsh.sourceforge.io/)                     |
| **Shell Theme**     | [Powerlevel10k](https://github.com/romkatv/powerlevel10k)            | <img src="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/prompt-styles-high-contrast.png" width="24" alt="P10k">                         | Fast and customizable prompt theme               | [GitHub](https://github.com/romkatv/powerlevel10k)         |
| **Terminal**        | [Terminator](https://gnome-terminator.org/)                          | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Gnome-Terminator.svg/1200px-Gnome-Terminator.svg.png" width="24" alt="Terminator">         | Advanced terminal emulator with multiple panes   | [gnome-terminator.org](https://gnome-terminator.org/)      |
| **JavaScript**      | [Node.js](https://nodejs.org/)                                       | <img src="https://cdn-icons-png.flaticon.com/512/5968/5968322.png" width="24" alt="Node.js">                                                                   | JavaScript runtime built on Chrome's V8 engine   | [nodejs.org](https://nodejs.org/)                          |
| **JavaScript**      | [Bun](https://bun.sh/)                                               | <img src="https://bun.sh/logo-square.png" width="24" alt="Bun">                                                                                                | Fast all-in-one JavaScript runtime & toolkit     | [bun.sh](https://bun.sh/)                                  |
| **Package Manager** | [NPM](https://www.npmjs.com/)                                        | <img src="https://static-production.npmjs.com/b0f1a8318363185cc2ea6a40ac23eeb2.png" width="24" alt="npm">                                                      | Package manager for JavaScript                   | [npmjs.com](https://www.npmjs.com/)                        |
| **Node Version**    | [n](https://github.com/tj/n)                                         | 🔢                                                                                                                                                             | Simple Node.js version management                | [GitHub](https://github.com/tj/n)                          |
| **Systems**         | [Rust](https://www.rust-lang.org/) + [Cargo](https://crates.io/)     | <img src="https://www.rust-lang.org/static/images/favicon-32x32.png" width="24" alt="Rust">                                                                    | Systems programming language with memory safety  | [rust-lang.org](https://www.rust-lang.org/)                |
| **Build Tools**     | [Nx](https://nx.dev/)                                                | <img src="https://images.seeklogo.com/logo-png/42/2/nx-logo-png_seeklogo-428035.png" width="24" alt="Nx">                                                                                | Smart monorepos build system                     | [nx.dev](https://nx.dev/)                                  |
| **Framework**       | [@angular/cli](https://angular.io/cli)                               | <img src="https://angular.io/assets/images/favicons/favicon-32x32.png" width="24" alt="Angular">                                                               | Angular development CLI                          | [angular.io](https://angular.io/cli)                       |
| **Development**     | [http-server](https://github.com/http-party/http-server)             | 🌐                                                                                                                                                             | Simple HTTP server for development               | [GitHub](https://github.com/http-party/http-server)        |
| **Containers**      | [Docker CE](https://www.docker.com/)                                 | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker">                                                       | Container platform for applications              | [docker.com](https://www.docker.com/)                      |
| **Containers**      | [Docker Compose](https://docs.docker.com/compose/)                   | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker">                                                       | Multi-container Docker applications              | [docs.docker.com](https://docs.docker.com/compose/)        |
| **Version Control** | [Git](https://git-scm.com/)                                          | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Git_icon.svg/2048px-Git_icon.svg.png" width="24" alt="Git">                              | Distributed version control system               | [git-scm.com](https://git-scm.com/)                        |
| **Git Enhancement** | [delta](https://github.com/dandavison/delta)                         | ✨                                                                                                                                                             | A syntax-highlighting pager for Git              | [GitHub](https://github.com/dandavison/delta)              |
| **Git CLI**         | [GitHub CLI](https://cli.github.com/)                                | <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="24" alt="GitHub">                                                  | GitHub operations from command line              | [cli.github.com](https://cli.github.com/)                  |
| **Editor**          | [Visual Studio Code](https://code.visualstudio.com/)                 | <img src="https://code.visualstudio.com/favicon.ico" width="24" alt="VS Code">                                                                                 | Lightweight yet powerful code editor             | [code.visualstudio.com](https://code.visualstudio.com/)    |
| **Editor**          | [Vim](https://www.vim.org/)                                          | <img src="https://www.vim.org/images/vim_header.gif" width="24" alt="Vim">                                                                                     | Highly configurable text editor                  | [vim.org](https://www.vim.org/)                            |
| **Browser**         | [Google Chrome](https://www.google.com/chrome/)                      | <img src="https://www.google.com/chrome/static/images/favicons/favicon-32x32.png" width="24" alt="Chrome">                                                     | Modern web browser                               | [chrome.google.com](https://www.google.com/chrome/)        |
| **Communication**   | [Slack](https://slack.com/)                                          | <img src="https://slack.com/favicon.ico" width="24" alt="Slack">                                                                                               | Team collaboration platform                      | [slack.com](https://slack.com/)                            |
| **Font**            | [JetBrains Mono](https://www.jetbrains.com/lp/mono/)                 | <img src="https://www.jetbrains.com/favicon-32x32.png" width="24" alt="JetBrains">                                                                             | Programming font with ligatures                  | [jetbrains.com](https://www.jetbrains.com/lp/mono/)        |
| **Font**            | [JetBrains Mono Nerd](https://www.nerdfonts.com/)                    | <img src="https://www.nerdfonts.com/assets/img/nerd-fonts-logo.png" width="24" alt="Nerd Fonts">                                                               | Programming font with extra glyphs               | [nerdfonts.com](https://www.nerdfonts.com/)                |
| **Network**         | [cURL](https://curl.se/)                                             | <img src="https://curl.se/logo/curl-symbol.png" width="24" alt="cURL">                                                                                         | Command line tool for transferring data          | [curl.se](https://curl.se/)                                |
| **System**          | [htop](https://htop.dev/)                                            | 📊                                                                                                                                                             | Interactive process viewer                       | [htop.dev](https://htop.dev/)                              |
| **Files**           | [GNU Stow](https://www.gnu.org/software/stow/)                       | 📁                                                                                                                                                             | Symlink farm manager for dotfiles                | [gnu.org](https://www.gnu.org/software/stow/)              |
| **Screenshots**     | [Flameshot](https://flameshot.org/)                                  | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flameshot_logo.svg/96px-Flameshot_logo.svg.png?20210313192516" width="24" alt="Flameshot"> | Powerful screenshot tool                         | [flameshot.org](https://flameshot.org/)                    |
| **JSON**            | [jq](https://stedolan.github.io/jq/)                                 | 🔧                                                                                                                                                             | Lightweight command-line JSON processor          | [stedolan.github.io](https://stedolan.github.io/jq/)       |
| **System**          | [gnome-tweaks](https://wiki.gnome.org/Apps/Tweaks)                   | ⚙️                                                                                                                                                             | Advanced GNOME configuration tool                | [GNOME Wiki](https://wiki.gnome.org/Apps/Tweaks)           |
| **Files**           | [lsd](https://github.com/Peltoche/lsd)                               | 📂                                                                                                                                                             | Modern `ls` command with colors and icons        | [GitHub](https://github.com/Peltoche/lsd)                  |
| **Music**           | [Spotify](https://www.spotify.com/)                                  | <img src="https://open.spotifycdn.com/cdn/images/favicon32.b64ecc03.png" width="24" alt="Spotify">                                                             | Music streaming platform                         | [spotify.com](https://www.spotify.com/)                    |
| **Streaming**       | [OBS Studio](https://obsproject.com/)                                | <img src="https://obsproject.com/assets/images/new_icon_small-r.png" width="24" alt="OBS">                                                                     | Live streaming and screen recording              | [obsproject.com](https://obsproject.com/)                  |
| **Gaming**          | [Steam](https://store.steampowered.com/)                             | <img src="https://store.steampowered.com/favicon.ico" width="24" alt="Steam">                                                                                  | Gaming platform and digital distribution         | [steampowered.com](https://store.steampowered.com/)        |
| **Communication**   | [Discord](https://discord.com/)                                      | <img src="https://discord.com/assets/f8389ca1a741a115313bede9ac02e2c0.svg" width="24" alt="Discord">                                                           | Voice, video and text communication              | [discord.com](https://discord.com/)                        |
| **Infrastructure**  | [Terraform](https://www.terraform.io/)                               | <img src="https://static-00.iconduck.com/assets.00/file-type-terraform-icon-911x1024-hx7dqefh.png" width="24" alt="Terraform">                                                                                    | Infrastructure as Code tool                      | [terraform.io](https://www.terraform.io/)                  |
| **Cloud**           | [AWS CLI](https://aws.amazon.com/cli/)                               | <img src="https://aws.amazon.com/favicon.ico" width="24" alt="AWS">                                                                                            | Amazon Web Services command line interface       | [aws.amazon.com](https://aws.amazon.com/cli/)              |
| **Graphics**        | [GIMP](https://www.gimp.org/)                                        | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/The_GIMP_icon_-_gnome.svg/1024px-The_GIMP_icon_-_gnome.svg.png" width="24" alt="GIMP">     | GNU Image Manipulation Program                   | [gimp.org](https://www.gimp.org/)                          |
| **Database**        | [MongoDB Compass](https://www.mongodb.com/products/compass)          | <img src="https://www.mongodb.com/assets/images/global/favicon.ico" width="24" alt="MongoDB">                                                                  | GUI for MongoDB database                         | [mongodb.com](https://www.mongodb.com/products/compass)    |
| **Database**        | [MongoDB CLI (mongosh)](https://www.mongodb.com/docs/mongodb-shell/) | <img src="https://www.mongodb.com/assets/images/global/favicon.ico" width="24" alt="MongoDB">                                                                  | MongoDB command line interface                   | [mongodb.com](https://www.mongodb.com/docs/mongodb-shell/) |
| **Python**          | [UV](https://github.com/astral-sh/uv)                                | <img src="https://miro.medium.com/v2/resize:fit:1400/1*eSnM1h_RX2tgE10fyE3w4Q.png" width="24" alt="UV">                                                        | Ultra-fast Python package and project manager    | [github.com](https://github.com/astral-sh/uv)              |
| **Video**           | [Zoom](https://zoom.us/)                                             | <img src="https://zoom.us/favicon.ico" width="24" alt="Zoom">                                                                                                  | Video conferencing platform                      | [zoom.us](https://zoom.us/)                                |
