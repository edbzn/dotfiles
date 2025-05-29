# Force Installation Feature

The force installation feature allows you to reinstall your dotfiles environment completely, regardless of the current state of installed packages and configurations.

## Overview

The `force-install.sh` script provides a robust way to:
- Force reinstallation of all packages and configurations
- Override existing installations without manual cleanup
- Support dry-run mode for testing changes
- Handle selective installation with tags
- Provide clear feedback and error handling

## Usage

### Basic Force Installation

```bash
# Force install everything
./force-install.sh

# Force install with confirmation prompt
./force-install.sh --ask-become-pass
```

### Selective Installation with Tags

```bash
# Force install specific roles
./force-install.sh --tags zsh,docker,node

# Force install excluding specific roles
./force-install.sh --skip-tags slack,chrome
```

### Dry Run Mode

```bash
# Test what would be changed without making actual changes
./force-install.sh --check

# Test with detailed diff output
./force-install.sh --check --diff

# Test specific roles
./force-install.sh --check --tags docker,chrome
```

### Verbose Output

```bash
# Enable verbose output for debugging
./force-install.sh --verbose

# Enable extra verbose output
./force-install.sh -vv
```

## Available Roles

| Role | Description | Force Install Behavior |
|------|-------------|------------------------|
| `bootstrap` | Basic system packages and tools | Reinstalls packages via apt |
| `zsh` | Zsh shell and Oh My Zsh configuration | Removes existing oh-my-zsh directory and reinstalls |
| `docker` | Docker Engine and Docker Compose | Removes packages, repository, and GPG key before reinstalling |
| `node` | Node.js, npm, Bun, and global packages | Removes existing installations and reinstalls fresh |
| `chrome` | Google Chrome browser | Removes package, repository, and GPG key before reinstalling |
| `vscode` | Visual Studio Code editor | Removes package, repository, and GPG key before reinstalling |
| `slack` | Slack desktop application | Removes both snap and deb installations before reinstalling |

## Force Install Behavior

When `force_install=true` is set, each role performs the following actions:

### 1. Cleanup Phase
- Removes existing packages/installations
- Cleans up configuration directories
- Removes repository configurations and GPG keys
- Handles both package manager and manual installations

### 2. Fresh Installation Phase
- Downloads and installs packages from scratch
- Recreates configuration directories
- Applies fresh configurations
- Installs dependencies and extensions

### 3. Error Handling
- Uses `ignore_errors: true` for cleanup tasks to prevent failures
- Continues installation even if cleanup partially fails
- Provides clear error messages and recovery guidance

## Ansible Integration

The force install feature integrates seamlessly with the existing Ansible playbook:

```yaml
# In playbook.yml
- name: Force Install Example
  hosts: localhost
  vars:
    force_install: true  # This variable triggers force behavior
  roles:
    - bootstrap
    - zsh
    - docker
    # ... other roles
```

## Command Line Options

All Ansible command-line options are supported and passed through:

| Option | Description |
|--------|-------------|
| `--check` | Dry run mode - show what would be changed |
| `--diff` | Show detailed differences for file changes |
| `--tags TAGS` | Run only roles with specified tags |
| `--skip-tags TAGS` | Skip roles with specified tags |
| `--verbose` | Enable verbose output |
| `--ask-become-pass` | Prompt for sudo password |
| `--limit HOST` | Limit to specific hosts |

## Examples

### Complete Environment Rebuild
```bash
# Full force installation with confirmation
./force-install.sh --ask-become-pass

# Expected output:
# 🔄 Force Installing Dotfiles Environment
# ⚠️  This will reinstall everything regardless of current state
#
# 🏷️  Installing all roles
#
# Do you want to continue? (y/N): y
# Running command: ansible-playbook -i hosts playbook.yml --ask-become-pass -e force_install=true
```

### Development Environment Setup
```bash
# Force install just development tools
./force-install.sh --tags zsh,node,docker,vscode

# Test changes before applying
./force-install.sh --check --tags node,docker
```

### Troubleshooting Installation
```bash
# Debug installation issues with verbose output
./force-install.sh --verbose --tags slack

# Check what files would be modified
./force-install.sh --check --diff --tags zsh
```

## Safety Features

1. **Confirmation Prompts**: Interactive confirmation before destructive operations
2. **Dry Run Support**: Test changes with `--check` before applying
3. **Granular Control**: Use tags to control which components are reinstalled
4. **Error Recovery**: Graceful handling of partial failures
5. **Clear Feedback**: Color-coded output and progress indicators

## Troubleshooting

### Common Issues

1. **Permission Errors**: Use `--ask-become-pass` for sudo access
2. **Network Issues**: Check internet connectivity for package downloads
3. **Partial Failures**: Review output and rerun with specific tags
4. **Repository Conflicts**: Force install cleans up repositories automatically

### Recovery

If force installation fails:

1. Check the error output for specific issues
2. Run with `--check` to identify problems
3. Use `--tags` to reinstall specific components
4. Manual cleanup may be needed for corrupted states

## Implementation Details

The force install feature works by:

1. **Variable Injection**: Sets `force_install=true` in Ansible variables
2. **Conditional Logic**: Each role checks `force_install` variable
3. **Cleanup Tasks**: Removes existing installations when force install is enabled
4. **Fresh Installation**: Proceeds with installation regardless of current state

### Role Structure Example

```yaml
- name: Check if package is installed
  shell: command -v package
  register: package_exists
  failed_when: false

- name: Remove existing installation for force install
  apt:
    name: package
    state: absent
  when: force_install and package_exists.rc == 0
  ignore_errors: true

- name: Install package
  apt:
    name: package
    state: present
  when: force_install or package_exists.rc != 0
```

This ensures clean, reliable installations every time.
