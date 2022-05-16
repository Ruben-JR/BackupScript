#!/bin/bash
#
# Home Directory Backup Script
#
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="/tmp"
TMP_DIR="/home/ruben/tmp"
BACKUP_NAME="home-backup"
EXTENTION="tar.gz"
BKP=$BACKUP_DIR/$BACKUP_NAME-$DATE.$EXTENTION
DOWNLOAD_DIR="$HOME/Downloads"
REMOTE_USER="ruben"
REMOTE_BKP_FOLDER="/home/ruben/backup"
REMOTE_HOST="ninhu.duckdns.org"
#
# su tiver um pasta temporatio ku kre fazi backup tb, mas delete alguns cenas antigo antes, descomenta kel for li, e comenta kel ki sta descomentado.
#for i in $TMP_DIR $DOWNLOAD_DIR ; 
for i in $DOWNLOAD_DIR/ ;
        # keli ta busca files dentu pasta Download ki teni mas di 10 dia, e delete antes fazi backup.
        find $i -type f -mtime +7 -exec rm -rf {} \;
    done;

tar -cJpf $BKP $HOME/{Documents,Downloads,Videos,.config/{nvim,sops/,qmk,Joplin,joplin-desktop},.zshrc,.zsh_history}

# delete backup na servidor remoto ki teni mas di `n` dias. nes caso 15
# find and remove files older than 7 days
ssh -l $REMOTE_USER $REMOTE_HOST "find $REMOTE_BKP_FOLDER/* -type f -mtime +15 -exec rm -rf {} \;"

# copy backup to remote folder
rsync -avz $BACKUP_DIR/$BACKUP_NAME-$DATE.$EXTENTION $REMOTE_USER@$REMOTE_HOST:$REMOTE_BKP_FOLDER/

#keli ta remove backup di bu PC, dipos di copial pa servidor remoto.
rm -rf $BKP   