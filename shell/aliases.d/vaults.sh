# backups
alias backup-documents-to-storage1-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage1-vault/backups/documents/'
alias backup-documents-to-storage2-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage2-vault/backup/documents/'
alias backup-documents-to-storage3-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage3-vault/backups/documents/'

# decrypt/un-decrypt vaults
alias open-documents-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/documents" $HOME/nextcloud/vault/ $HOME/vaults/documents-vault'
alias close-documents-vault='fusermount -q -u $HOME/vaults/documents-vault'
alias open-dropbox-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/dropbox" $HOME/documents/dropbox/vault/ $HOME/vaults/dropbox-vault'
alias close-dropbox-vault='fusermount -q -u $HOME/vaults/dropbox-vault'
alias open-stick1-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/sticks" /media/$USER/WA-STICK1/.vault/ $HOME/vaults/stick1-vault'
alias close-stick1-vault='fusermount -q -u $HOME/vaults/stick1-vault'
alias open-stick2-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/sticks" /media/$USER/WA-STICK2/.vault/ $HOME/vaults/stick2-vault'
alias close-stick2-vault='fusermount -q -u $HOME/vaults/stick2-vault'
alias open-stick3-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/sticks" /media/$USER/WA-STICK3/.vault/ $HOME/vaults/stick3-vault'
alias close-stick3-vault='fusermount -q -u $HOME/vaults/stick3-vault'
alias open-stick4-vault='gocryptfs -q -extpass "pass getraenkemarkt/vaults/sticks" /media/$USER/WA-STICK4/.vault/ $HOME/vaults/stick4-vault'
alias close-stick4-vault='fusermount -q -u $HOME/vaults/stick4-vault'
