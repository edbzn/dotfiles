# Secrets Management with Ansible Vault

This repository uses Ansible Vault to securely store and sync SSH and GPG keys across machines.

## 🔐 How It Works

1. **Encryption**: Your private keys are encrypted using Ansible Vault with a password you choose
2. **Storage**: Encrypted keys are safely committed to your git repository
3. **Decryption**: On new machines, the keys are automatically decrypted during installation
4. **Security**: Only you have the vault password - it's never committed to git

## 🚀 Initial Setup

### 1. Create Vault Password

First, create a vault password file (this is done once):

```bash
echo "your-very-secure-password" > ~/dotfiles/.vault_password
chmod 600 ~/dotfiles/.vault_password
```

⚠️ **IMPORTANT**:
- Choose a strong, memorable password
- This file is in `.gitignore` and will NEVER be committed
- Keep this password safe - you'll need it on every machine
- Consider storing it in a password manager

### 2. Backup Your Keys

Use the backup script to encrypt and store your keys:

```bash
~/dotfiles/backup-secrets.sh
```

The script will:
- Prompt you to select SSH keys, GPG keys, shell history, or all
- Automatically filter secrets from shell history
- Encrypt them with your vault password
- Save encrypted versions to `secrets/` directory

### 3. Commit Encrypted Keys

```bash
cd ~/dotfiles
git add secrets/
git commit -m "Add encrypted SSH and GPG keys"
git push
```

## 🔄 Using on New Machines

### 1. Clone Repository

```bash
git clone git@github.com:edbzn/dotfiles.git ~/dotfiles
```

### 2. Create Vault Password File

```bash
echo "your-very-secure-password" > ~/dotfiles/.vault_password
chmod 600 ~/dotfiles/.vault_password
```

Use the **same password** you used when encrypting the keys!

### 3. Run Installation

```bash
~/dotfiles/install.sh
```

The installation will automatically:
- Detect encrypted keys in `secrets/` directory
- Decrypt and restore your SSH keys to `~/.ssh/`
- Import your GPG keys
- Restore your shell history (with secrets already filtered)
- Set correct permissions

## 📋 What Gets Encrypted

### SSH Keys
- `~/.ssh/id_ed25519` → `secrets/id_ed25519.vault` (or your key name)
- `~/.ssh/id_ed25519.pub` → `secrets/id_ed25519.pub.vault`

### GPG Keys
- Your GPG private key → `secrets/gpg-private-key.asc.vault`

### Shell History
- `~/.zsh_history` → `secrets/zsh_history.vault` (secrets automatically filtered)

## 🔧 Manual Operations

### Encrypt a File Manually

```bash
ansible-vault encrypt path/to/file \
  --vault-id default@~/dotfiles/.vault_password \
  --encrypt-vault-id default \
  --output=secrets/filename.vault
```

### Decrypt a File Manually

```bash
ansible-vault decrypt secrets/filename.vault \
  --vault-id default@~/dotfiles/.vault_password \
  --output=path/to/destination
```

### View Encrypted File Contents

```bash
ansible-vault view secrets/id_ed25519.vault \
  --vault-id default@~/dotfiles/.vault_password
```

### Edit Encrypted File

```bash
ansible-vault edit secrets/gpg-private-key.asc.vault \
  --vault-id default@~/dotfiles/.vault_password
```

### Rotate Vault Password

```bash
# Create new password file
echo "new-secure-password" > ~/dotfiles/.vault_password_new

# Rekey all encrypted files
ansible-vault rekey secrets/*.vault \
  --vault-id default@~/dotfiles/.vault_password \
  --new-vault-id default@~/dotfiles/.vault_password_new

# Replace old password file
mv ~/dotfiles/.vault_password_new ~/dotfiles/.vault_password
```

## 🔍 Run Secrets Role Only

To only restore keys without running full installation:

```bash
cd ~/dotfiles
ansible-playbook playbook.yml --tags secrets
```

## ❓ Troubleshooting

### "Decryption failed" Error

Make sure:
1. `.vault_password` file exists and contains the correct password
2. The password matches what you used to encrypt the keys
3. File permissions are correct: `chmod 600 .vault_password`

### Keys Not Restored

Check if encrypted keys exist:
```bash
ls -la ~/dotfiles/secrets/
```

If empty, you need to run `backup-secrets.sh` on a machine that has the keys.

### Testing Vault Password

```bash
# Test if password is correct
ansible-vault view secrets/id_ed25519.vault \
  --vault-id default@~/dotfiles/.vault_password
```

If this works, your password is correct!

## 🛡️ Security Best Practices

1. **Never Commit Vault Password**: Already in `.gitignore`
2. **Use Strong Password**: Mix letters, numbers, symbols
3. **Store Password Safely**: Use a password manager
4. **Rotate Periodically**: Change vault password every 6-12 months
5. **Backup Keys**: Keep encrypted backup outside git too
6. **Audit Access**: Monitor who has access to your repository

## 🔗 Alternative Key Storage

If you prefer not to store keys in git (even encrypted), alternatives:

1. **Password Manager**: 1Password, Bitwarden have SSH agent support
2. **Hardware Key**: YubiKey can store GPG/SSH keys physically
3. **Cloud Storage**: Encrypt and upload to Dropbox/Drive separately

The ansible-vault method works great for teams or multiple personal machines! 🎉
