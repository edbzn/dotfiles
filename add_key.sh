#!/bin/sh

# Load Keychain to handle SSH and GPG keys
if [ -f /usr/bin/keychain ]; then
    /usr/bin/keychain id_rsa 0x12345 0x23456
    $HOME/.keychain/`hostname`-sh
    $HOME/.keychain/`hostname`-sh-gpg
fi
