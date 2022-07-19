echo -e '\n\033[36m\033[2m\033[1m\033[7mCreating mount folders for gocryptfs vaults\033[0m\n'
mkdir -p "$HOME/.vault/documents"
echo 'This folder contains the mount points for the gocryptfs vaults.' > "$HOME/.vault/README.md"
