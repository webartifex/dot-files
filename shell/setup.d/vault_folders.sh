echo -e '\n\033[36m\033[2m\033[1m\033[7mCreating mount folders for gocryptfs vaults\033[0m\n'
mkdir -p "$HOME/vaults/documents-vault"
mkdir -p "$HOME/vaults/stick1-vault"
mkdir -p "$HOME/vaults/stick2-vault"
mkdir -p "$HOME/vaults/stick3-vault"
mkdir -p "$HOME/vaults/stick4-vault"
echo 'This folder contains the mount points for the gocryptfs vaults.' > "$HOME/vaults/README.md"
