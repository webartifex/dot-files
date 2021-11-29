# backups
alias backup-dropbox-vault-to-storage1-vault='rsync -r -t -p -o -g -x -v --progress --delete -s /home/webartifex/vaults/dropbox-vault/ /home/webartifex/vaults/storage1-vault/backups/vault/'
alias backup-dropbox-vault-to-storage2-vault='rsync -r -t -p -o -g -x -v --progress --delete -s /home/webartifex/vaults/dropbox-vault/ /home/webartifex/vaults/storage2-vault/backups/vault/'
alias backup-dropbox-vault-to-storage3-vault='rsync -r -t -p -o -g -x -v --progress --delete -s /home/webartifex/vaults/dropbox-vault/ /home/webartifex/vaults/storage3-vault/backups/vault/'

# decrypt/un-decrypt vaults

alias open-dropbox-vault='gocryptfs -q -extpass "pass misc/dropbox-vault" $HOME/.dropbox/.sync/Dropbox/vault/ $HOME/vaults/dropbox-vault'
alias close-dropbox-vault='fusermount -q -u $HOME/vaults/dropbox-vault'

alias open-stick1-vault='gocryptfs -q -extpass "pass misc/usb-stick-vaults" /media/$USER/WA-STICK1/.vault/ $HOME/vaults/stick1-vault'
alias close-stick1-vault='fusermount -q -u $HOME/vaults/stick1-vault'
alias open-stick2-vault='gocryptfs -q -extpass "pass misc/usb-stick-vaults" /media/$USER/WA-STICK2/.vault/ $HOME/vaults/stick2-vault'
alias close-stick2-vault='fusermount -q -u $HOME/vaults/stick2-vault'
alias open-stick3-vault='gocryptfs -q -extpass "pass misc/usb-stick-vaults" /media/$USER/WA-STICK3/.vault/ $HOME/vaults/stick3-vault'
alias close-stick3-vault='fusermount -q -u $HOME/vaults/stick3-vault'
alias open-stick4-vault='gocryptfs -q -extpass "pass misc/usb-stick-vaults" /media/$USER/WA-STICK4/.vault/ $HOME/vaults/stick4-vault'
alias close-stick4-vault='fusermount -q -u $HOME/vaults/stick4-vault'

alias open-storage1-vault='gocryptfs -q -extpass "pass misc/storage-vaults" /media/$USER/wa-Storage1/ $HOME/vaults/storage1-vault'
alias close-storage1-vault='fusermount -q -u $HOME/vaults/storage1-vault'
alias open-storage2-vault='gocryptfs -q -extpass "pass misc/storage-vaults" /media/$USER/wa-Storage2/ $HOME/vaults/storage2-vault'
alias close-storage2-vault='fusermount -q -u $HOME/vaults/storage2-vault'
alias open-storage3-vault='gocryptfs -q -extpass "pass misc/storage-vaults" /media/$USER/wa-Storage3/ $HOME/vaults/storage3-vault'
alias close-storage3-vault='fusermount -q -u $HOME/vaults/storage3-vault'
