#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
SECRETS_DIR="$DOTFILES_DIR/secrets"
VAULT_PASSWORD_FILE="$DOTFILES_DIR/.vault_password"

echo "🔐 Secrets Backup Script"
echo "========================"
echo ""

# Check if vault password file exists
if [ ! -f "$VAULT_PASSWORD_FILE" ]; then
    echo "❌ Vault password file not found at: $VAULT_PASSWORD_FILE"
    echo ""
    echo "Please create it first:"
    echo "  echo 'your-secure-password' > $VAULT_PASSWORD_FILE"
    echo "  chmod 600 $VAULT_PASSWORD_FILE"
    echo ""
    echo "⚠️  WARNING: Keep this password safe! You'll need it to decrypt your keys."
    exit 1
fi

# Create secrets directory
mkdir -p "$SECRETS_DIR"

echo "📋 Select what to backup:"
echo "  1) SSH keys"
echo "  2) GPG keys"
echo "  3) Both"
echo ""
read -p "Enter your choice (1-3): " choice

encrypt_ssh_keys() {
    echo ""
    echo "🔑 Encrypting SSH keys..."

    # Detect available SSH private keys
    SSH_KEYS=($(find ~/.ssh -maxdepth 1 -type f -name "id_*" ! -name "*.pub" 2>/dev/null))

    if [ ${#SSH_KEYS[@]} -eq 0 ]; then
        echo "⚠️  No SSH private keys found in ~/.ssh/"
        echo "    Looking for files like: id_rsa, id_ed25519, id_ecdsa, etc."
        return 1
    fi

    echo "Available SSH keys:"
    for i in "${!SSH_KEYS[@]}"; do
        echo "  $((i+1))) ${SSH_KEYS[$i]}"
    done
    echo ""

    if [ ${#SSH_KEYS[@]} -eq 1 ]; then
        echo "Using: ${SSH_KEYS[0]}"
        SSH_KEY="${SSH_KEYS[0]}"
    else
        read -p "Select SSH key to backup (1-${#SSH_KEYS[@]}): " key_choice
        SSH_KEY="${SSH_KEYS[$((key_choice-1))]}"
    fi

    if [ -z "$SSH_KEY" ] || [ ! -f "$SSH_KEY" ]; then
        echo "❌ Invalid selection"
        return 1
    fi

    KEY_NAME=$(basename "$SSH_KEY")
    echo "Encrypting $KEY_NAME..."

    # Create a temporary directory
    TEMP_DIR=$(mktemp -d)

    # Create a temporary copy to encrypt (preserves original)
    cp "$SSH_KEY" "$TEMP_DIR/ssh_key_temp"

    ansible-vault encrypt "$TEMP_DIR/ssh_key_temp" \
        --vault-id default@"$VAULT_PASSWORD_FILE" \
        --encrypt-vault-id default \
        --output="$SECRETS_DIR/${KEY_NAME}.vault"

    rm -rf "$TEMP_DIR"

    if [ -f "${SSH_KEY}.pub" ]; then
        TEMP_DIR=$(mktemp -d)
        cp "${SSH_KEY}.pub" "$TEMP_DIR/ssh_key_pub_temp"

        ansible-vault encrypt "$TEMP_DIR/ssh_key_pub_temp" \
            --vault-id default@"$VAULT_PASSWORD_FILE" \
            --encrypt-vault-id default \
            --output="$SECRETS_DIR/${KEY_NAME}.pub.vault"

        rm -rf "$TEMP_DIR"
    fi

    echo "✅ SSH keys encrypted and saved to $SECRETS_DIR/"
}

encrypt_gpg_keys() {
    echo ""
    echo "🔑 Encrypting GPG keys..."

    # List available GPG keys
    echo ""
    echo "Available GPG secret keys:"
    gpg --list-secret-keys --keyid-format=long
    echo ""

    read -p "Enter the GPG Key ID to backup (e.g., A82C9B5DFAEE5852): " gpg_key_id

    if [ -z "$gpg_key_id" ]; then
        echo "❌ No key ID provided"
        return 1
    fi

    # Export GPG private key
    echo "Exporting GPG private key..."
    TEMP_DIR=$(mktemp -d)
    gpg --export-secret-keys --armor "$gpg_key_id" > "$TEMP_DIR/gpg-private.asc"

    # Encrypt with ansible-vault
    ansible-vault encrypt "$TEMP_DIR/gpg-private.asc" \
        --vault-id default@"$VAULT_PASSWORD_FILE" \
        --encrypt-vault-id default \
        --output="$SECRETS_DIR/gpg-private-key.asc.vault"

    # Clean up temporary directory
    rm -rf "$TEMP_DIR"

    echo "✅ GPG key encrypted and saved to $SECRETS_DIR/"
}

case $choice in
    1)
        encrypt_ssh_keys
        ;;
    2)
        encrypt_gpg_keys
        ;;
    3)
        encrypt_ssh_keys
        encrypt_gpg_keys
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "✅ Backup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Commit the encrypted keys:"
echo "     cd $DOTFILES_DIR"
echo "     git add secrets/"
echo "     git commit -m 'Add encrypted SSH/GPG keys'"
echo "     git push"
echo ""
echo "  2. On a new machine, run the install script and it will automatically restore your keys"
echo ""
echo "⚠️  IMPORTANT: Keep your vault password file ($VAULT_PASSWORD_FILE) safe!"
echo "    It's already in .gitignore and should NEVER be committed."
