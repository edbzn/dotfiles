<img src="./.assets/dotfiles-logo.png" width="300" alt="dotfiles">

This repository provides my ready-to-use dev environment in seconds using [Ansible](https://www.ansible.com
) and [GNU Stow](https://www.gnu.org/software/stow/).

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

The update script provides **complete reinstallation** of all tools regardless of current state, ensuring a clean and consistent environment. Like the installation, updates are also **idempotent** and safe to run multiple times.

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

> 📖 **Comprehensive Documentation**: For detailed update features and advanced usage, see [UPDATE_FEATURES.md](./UPDATE_FEATURES.md).

## Tools

The following tools are automatically installed and configured:

| Category | Tool | Logo | Description | Documentation |
|----------|------|------|-------------|---------------|
| **Shell** | [Zsh](https://zsh.sourceforge.io/) + [Oh My Zsh](https://ohmyz.sh/) | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Zsh_logo.svg/32px-Zsh_logo.svg.png" width="24" alt="Zsh"> | Enhanced shell with powerful features and themes | [zsh.org](https://zsh.sourceforge.io/) |
| **Shell Theme** | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | <img src="https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/powerlevel10k-logo.png" width="24" alt="P10k"> | Fast and customizable prompt theme | [GitHub](https://github.com/romkatv/powerlevel10k) |
| **Terminal** | [Terminator](https://gnome-terminator.org/) | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Terminator-logo.png/32px-Terminator-logo.png" width="24" alt="Terminator"> | Advanced terminal emulator with multiple panes | [gnome-terminator.org](https://gnome-terminator.org/) |
| **JavaScript** | [Node.js](https://nodejs.org/) | <img src="https://nodejs.org/static/images/favicons/favicon-32x32.png" width="24" alt="Node.js"> | JavaScript runtime built on Chrome's V8 engine | [nodejs.org](https://nodejs.org/) |
| **JavaScript** | [Bun](https://bun.sh/) | <img src="https://bun.sh/logo-square.png" width="24" alt="Bun"> | Fast all-in-one JavaScript runtime & toolkit | [bun.sh](https://bun.sh/) |
| **Package Manager** | [NPM](https://www.npmjs.com/) | <img src="https://static-production.npmjs.com/b0f1a8318363185cc2ea6a40ac23eeb2.png" width="24" alt="npm"> | Package manager for JavaScript | [npmjs.com](https://www.npmjs.com/) |
| **Node Version** | [n](https://github.com/tj/n) | 🔢 | Simple Node.js version management | [GitHub](https://github.com/tj/n) |
| **Systems** | [Rust](https://www.rust-lang.org/) + [Cargo](https://crates.io/) | <img src="https://www.rust-lang.org/static/images/favicon-32x32.png" width="24" alt="Rust"> | Systems programming language with memory safety | [rust-lang.org](https://www.rust-lang.org/) |
| **Build Tools** | [Nx](https://nx.dev/) | <img src="https://nx.dev/documentation/shared/nx-logo.png" width="24" alt="Nx"> | Smart monorepos build system | [nx.dev](https://nx.dev/) |
| **Framework** | [@angular/cli](https://angular.io/cli) | <img src="https://angular.io/assets/images/favicons/favicon-32x32.png" width="24" alt="Angular"> | Angular development CLI | [angular.io](https://angular.io/cli) |
| **Development** | [http-server](https://github.com/http-party/http-server) | 🌐 | Simple HTTP server for development | [GitHub](https://github.com/http-party/http-server) |
| **Containers** | [Docker CE](https://www.docker.com/) | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker"> | Container platform for applications | [docker.com](https://www.docker.com/) |
| **Containers** | [Docker Compose](https://docs.docker.com/compose/) | <img src="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png.webp" width="24" alt="Docker"> | Multi-container Docker applications | [docs.docker.com](https://docs.docker.com/compose/) |
| **Version Control** | [Git](https://git-scm.com/) | <img src="https://git-scm.com/images/logos/downloads/Git-Icon-32px.png" width="24" alt="Git"> | Distributed version control system | [git-scm.com](https://git-scm.com/) |
| **Git Enhancement** | [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) | ✨ | Human-readable diffs for Git | [GitHub](https://github.com/so-fancy/diff-so-fancy) |
| **Git CLI** | [GitHub CLI](https://cli.github.com/) | <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="24" alt="GitHub"> | GitHub operations from command line | [cli.github.com](https://cli.github.com/) |
| **Editor** | [Visual Studio Code](https://code.visualstudio.com/) | <img src="https://code.visualstudio.com/favicon.ico" width="24" alt="VS Code"> | Lightweight yet powerful code editor | [code.visualstudio.com](https://code.visualstudio.com/) |
| **Editor** | [Vim](https://www.vim.org/) | <img src="https://www.vim.org/images/vim_header.gif" width="24" alt="Vim"> | Highly configurable text editor | [vim.org](https://www.vim.org/) |
| **Browser** | [Google Chrome](https://www.google.com/chrome/) | <img src="https://www.google.com/chrome/static/images/favicons/favicon-32x32.png" width="24" alt="Chrome"> | Modern web browser | [chrome.google.com](https://www.google.com/chrome/) |
| **Communication** | [Slack](https://slack.com/) | <img src="https://slack.com/favicon.ico" width="24" alt="Slack"> | Team collaboration platform | [slack.com](https://slack.com/) |
| **Font** | [JetBrains Mono](https://www.jetbrains.com/lp/mono/) | <img src="https://www.jetbrains.com/favicon-32x32.png" width="24" alt="JetBrains"> | Programming font with ligatures | [jetbrains.com](https://www.jetbrains.com/lp/mono/) |
| **Font** | [JetBrains Mono Nerd](https://www.nerdfonts.com/) | <img src="https://www.nerdfonts.com/assets/img/nerd-fonts-logo.png" width="24" alt="Nerd Fonts"> | Programming font with extra glyphs | [nerdfonts.com](https://www.nerdfonts.com/) |
| **Network** | [cURL](https://curl.se/) | <img src="https://curl.se/logo/curl-logo.svg" width="24" alt="cURL"> | Command line tool for transferring data | [curl.se](https://curl.se/) |
| **System** | [htop](https://htop.dev/) | 📊 | Interactive process viewer | [htop.dev](https://htop.dev/) |
| **Files** | [GNU Stow](https://www.gnu.org/software/stow/) | 📁 | Symlink farm manager for dotfiles | [gnu.org](https://www.gnu.org/software/stow/) |
| **Screenshots** | [Flameshot](https://flameshot.org/) | <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flameshot_logo.svg/96px-Flameshot_logo.svg.png?20210313192516" width="24" alt="Flameshot"> | Powerful screenshot tool | [flameshot.org](https://flameshot.org/) |
| **JSON** | [jq](https://stedolan.github.io/jq/) | 🔧 | Lightweight command-line JSON processor | [stedolan.github.io](https://stedolan.github.io/jq/) |
| **System** | [gnome-tweaks](https://wiki.gnome.org/Apps/Tweaks) | ⚙️ | Advanced GNOME configuration tool | [GNOME Wiki](https://wiki.gnome.org/Apps/Tweaks) |
| **Files** | [lsd](https://github.com/Peltoche/lsd) | 📂 | Modern `ls` command with colors and icons | [GitHub](https://github.com/Peltoche/lsd) |

> 🎯 **Smart Installation**: Each tool is configured with sensible defaults and optimizations for development productivity. The installation is completely automated and idempotent.

## Key Features

- 🔧 **Idempotent Setup** - Safe to run multiple times without side effects
- 🚀 **Zero-Config** - Everything works out of the box with sensible defaults
- 🎨 **Beautiful UI** - Modern themes and fonts for enhanced productivity
- 🔄 **Smart Updates** - Intelligent updates with dry-run and selective installation
- 🐳 **Container Ready** - Full Docker environment for modern development
- ⚡ **Performance Optimized** - Fast shell, modern tools, and optimized configurations
- 🛠️ **Developer Focused** - Curated selection of essential development tools
- 📦 **Modular Design** - Install only what you need with tag-based selection
