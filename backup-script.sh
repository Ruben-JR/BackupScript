#!/bin/bash
#
# Home Directory Backup Script
#
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="/tmp"
BACKUP_NAME="home-backup"
EXTENTION="tar.gz"
BKP=$BACKUP_DIR/$BACKUP_NAME-$DATE.$EXTENTION
DOWNLOAD_DIR="$HOME/Downloads"
REMOTE_USER="ruben"
REMOTE_BKP_FOLDER="/home/ruben/backup"
REMOTE_HOST="86.161.72.137"
#
#
#for i in $TMP_DIR $DOWNLOAD_DIR ;
#    do
#        find $i -type f -mtime +7 -exec rm -rf {} \;
#    done;

tar -cJpf $BKP $HOME/{.config/nvim,.zshrc,.zsh_history,Documents,.ssh}

#tar -cJpf $BKP $HOME/{Documents,Downloads,Videos,.config/{nvim,sops/,qmk,Joplin,joplin-desktop},.zshrc,.zsh_history}
#
#
# find and remove files older than 7 days
#ssh -l $REMOTE_USER $REMOTE_HOST "find $REMOTE_BKP_FOLDER/* -type f -mtime +15 -exec rm -rf {} \;"

# copy backup to remote folder
rsync -avz $BKP ruben@ninhu.duckdns.org:$REMOTE_BKP_FOLDER/

#keli ta remove backup di bu PC, dipos di copial pa servidor remoto.
#rm -rf $BKP
