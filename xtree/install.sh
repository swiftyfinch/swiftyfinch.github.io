#!/bin/bash

success() {
	printf "\e[32m$1\e[m\n"
}
error() {
	printf "\e[31m$1\e[m\n"
}
warning() {
	printf "\e[33m$1\e[m\n"
}

if command -v xtree &> /dev/null; then
	warning "🌳 xtree has already been installed."; exit
fi

# Get the current machine architecture
if [[ `arch` = arm64* ]]; then
	ARCH='arm64'
else
	ARCH='x86_64'
fi

# Download the latest xtree version for the current machine architecture
XTREE_DOWNLOADS="$HOME/.xtree/downloads"
XTREE_BIN_PATH="$HOME/.local/bin"
rm -rf "$XTREE_DOWNLOADS/downloads" && mkdir -p "$XTREE_DOWNLOADS/downloads" && cd "$XTREE_DOWNLOADS/downloads"
curl -sSLO "https://github.com/swiftyfinch/xtree/releases/latest/download/$ARCH.zip"
unzip -q "$ARCH.zip"
mkdir -p $XTREE_BIN_PATH
cp xtree $XTREE_BIN_PATH && rm -rf "$XTREE_DOWNLOADS/downloads"
success "🌳 xtree has been installed ✓"

# Check if xtree is in $PATH
if [[ ":${PATH}:" != *":$XTREE_BIN_PATH:"* ]]; then
	error "\n$XTREE_BIN_PATH is not in your \$PATH"
	warning "Add it manually to your shell profile."
	warning "For example, if you use zsh, run this command:"
	echo "\$ echo '\nexport PATH=\$PATH:~/.local/bin' >> ~/.zshrc"
	warning "Than open a new window or tab in the terminal for applying changes."
fi
