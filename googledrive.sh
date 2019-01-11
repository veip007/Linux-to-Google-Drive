#!/bin/sh
##-----------------------Database Access--------------------------##
DB_NAME="my-database-name"
DB_USER="my-database-user"
DB_PASSWORD="my-database-password"
##-----------------------Folder Web or Folder you want to backup--------------------------##
NameOfFolder=("yourdomain.com")
SourceOfFolder="/home/wwwroot"
BackupLocation="/backups"
date=$(date +"%Y-%m-%d")
##That mean, you will Backup the folder /home/wwwroot/yourdomain.com and will save into Folder /backups

if [ ! -d $BackupLocation ]; then
mkdir -p $BackupLocation
fi
find $BackupLocation/*.zip -mtime +10 -exec rm {} \;
for fd in $NameOfFolder; do
# Name of the Backup File
file=$fd-$date.zip

# Zip the Folder you will want to Backup
echo "Starting to zip the folder and files"
cd $SourceOfFolder
zip -r $BackupLocation/$file $fd
sleep 5s
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME | gzip > $BackupLocation/$date-$DB_NAME.sql.tar
sleep 5s
##Process Upload Files to Google Drive
gdrive upload --file /backups/$file
sleep 5s
gdrive upload --file /backups/$date-$DB_NAME.sql.tar
if test $? = 0
then
echo "Your Data Successfully Uploaded to the Google Drive!"
echo -e "Your Data Successfully created and uploaded to the Google Drive!" | mail -s "Your VPS Backup from $date" youremail@yourdomain.com
else
echo "Error in Your Data Upload to Google Drive" > $LOG_FILE
fi
done