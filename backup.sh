#!/bin/bash

# Specify which database is to be backed up
db_name="name_db"

# Set the website which this database relates to
website="folder_to_backup"

# Database credentials
user="root"
password="pass"
host="localhost"

# How many days would you like to keep files for?
days="3"

# Set the date
date=$(date +"%Y%m%d-%H%M")

# Set the location of where backups will be stored
backup_location="/var/backups/mysql"

# Create the directory for the website if it doesn't already exist
mkdir -p ${backup_location}/${website}
# Append the database name with the date to the backup location
backup_full_name="${backup_location}/${website}/${db_name}-${date}.sql"

# Set default file permissions
umask 177

# Dump database into SQL file
mysqldump --lock-tables --user=$user --password=$password --host=$host $db_name > $backup_full_name

# Set a value to be used to find all backups with the same name
find_backup_name="${backup_location}/${website}/${db_name}-*.sql"

# Delete files older than the number of days defined
find ${backup_location}/${website} -type f -mtime +$days -name '*.gz' -print0 | xargs -r0 rm --

# compress the file to reduce soace 
gzip -9 $backup_full_name
zipext='.gz'

# log the backed up file name in text file
echo "${backup_full_name}" > 'dbnam.txt'

#specify remote server to send the backup
scp "${backup_full_name}${zipext}" root@server_ip:/var/backups/mysql
#for the above process you need to add the ssh key of the current machine to the remote server

#create a crone job and point it to the location of your backup.sh
#sudo chmod +x backup.sh  ::::::: Make the bash script executable
#eg :: 0 0 * * * /var/backups/mysql/backup.sh
#this will run “At 00:00.” evry day