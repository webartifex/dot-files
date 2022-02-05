# backups
alias backup-documents-to-storage1-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage1-vault/backups/documents/'
alias backup-documents-to-storage2-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage2-vault/backup/documents/'
alias backup-documents-to-storage3-vault='rsync -r -t -p -o -g -x -v --progress --delete -s --exclude "#recycle" --exclude "#snapshot" --exclude "downloads" --exclude "dropbox" /home/webartifex/documents/ /home/webartifex/vaults/storage3-vault/backups/documents/'

# decrypt/un-decrypt vaults

alias open-documents-vault='gocryptfs -q -extpass "pass admin/vaults/documents" $HOME/documents/vault/ $HOME/vaults/documents-vault'
alias close-documents-vault='fusermount -q -u $HOME/vaults/documents-vault'

alias open-dropbox-vault='gocryptfs -q -extpass "pass admin/vaults/dropbox" $HOME/.dropbox/.sync/Dropbox/vault/ $HOME/vaults/dropbox-vault'
alias close-dropbox-vault='fusermount -q -u $HOME/vaults/dropbox-vault'

alias open-stick1-vault='gocryptfs -q -extpass "pass admin/vaults/sticks" /media/$USER/WA-STICK1/.vault/ $HOME/vaults/stick1-vault'
alias close-stick1-vault='fusermount -q -u $HOME/vaults/stick1-vault'
alias open-stick2-vault='gocryptfs -q -extpass "pass admin/vaults/sticks" /media/$USER/WA-STICK2/.vault/ $HOME/vaults/stick2-vault'
alias close-stick2-vault='fusermount -q -u $HOME/vaults/stick2-vault'
alias open-stick3-vault='gocryptfs -q -extpass "pass admin/vaults/sticks" /media/$USER/WA-STICK3/.vault/ $HOME/vaults/stick3-vault'
alias close-stick3-vault='fusermount -q -u $HOME/vaults/stick3-vault'
alias open-stick4-vault='gocryptfs -q -extpass "pass admin/vaults/sticks" /media/$USER/WA-STICK4/.vault/ $HOME/vaults/stick4-vault'
alias close-stick4-vault='fusermount -q -u $HOME/vaults/stick4-vault'

alias open-storage1-vault='gocryptfs -q -extpass "pass admin/vaults/storages" /media/$USER/wa-storage1/ $HOME/vaults/storage1-vault'
alias close-storage1-vault='fusermount -q -u $HOME/vaults/storage1-vault'
alias open-storage2-vault='gocryptfs -q -extpass "pass admin/vaults/storages" /media/$USER/wa-storage2/ $HOME/vaults/storage2-vault'
alias close-storage2-vault='fusermount -q -u $HOME/vaults/storage2-vault'
alias open-storage3-vault='gocryptfs -q -extpass "pass admin/vaults/storages" /media/$USER/wa-storage3/ $HOME/vaults/storage3-vault'
alias close-storage3-vault='fusermount -q -u $HOME/vaults/storage3-vault'
