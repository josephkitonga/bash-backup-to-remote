# Bash backup to remote server

This simple script will help you **Backup**  your  **mysql database**  and store it in a  **remote server** .
The script utilizes scp for secure file transfer to a remote server
Available compression options are gzip, files that are older than the specified days are deleted.

-create your backup directory
> sudo mkdir /var/backups/mysql/
> place the backup.sh in the directory
> cereate a new folder for the database backup

-for scp to work you need to add the ssh key of the current machine to the remote server
>use ssh-keygen to generate the key if you have not.
>add the key to the remote server in  ~/.ssh/authorized_keys

-create a crone job and point it to the location of your backup.sh.
> 0 0 * * * /var/backups/mysql/backup.sh
>this will run “At 00:00.” evry day

-Make the bash script executable
 > sudo chmod +x  /var/backups/mysql/backup.sh 
