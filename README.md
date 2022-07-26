# restic-backup-restore-b2
Docker image to initialize, backup to, and restore from a Restic repository on Backblaze B2.

## How to use it
1. Create a B2 bucket to hold your backups
2. Supply all appropriate environment variables
3. Initialize the Restic repository on B2 to hold the backups (one-time only)
4. Run a backup and check your bucket for that backup

### Environment variables
1. `B2_ACCOUNT_ID` - Backblaze keyID

2. `B2_ACCOUNT_KEY` - Backblaze applicationKey

3. `FSBACKUP_MODE=[init|backup|restore]` - `init` initializes the Restic repository at `$RESTIC_REPOSITORY` (only do this once); `backup` performs a backup; `restore` performs a restoration.

4. `RESTIC_BACKUP_ARGS` - additional arguments to pass to 'restic backup' command

5. `RESTIC_FORGET_ARGS` - additional arguments to pass to 'restic forget --prune' command (e.g., --keep-daily 7 --keep-weekly 5  --keep-monthly 3 --keep-yearly 2)

6. `RESTIC_HOST` - hostname to be used for the backup

7. `RESTIC_PASSWORD` - password for the Restic repository

8. `RESTIC_REPOSITORY` - Restic repository location (e.g., 'b2:bucketname:restic')

9. `RESTIC_TAG` - tag to apply to the backup

10. `SOURCE_PATH` - full path to the source directory to be backed up

11. `TARGET_PATH` - full path to the target directory to be restored to (usually the same as the SOURCE\_PATH)

It's recommended that your B2 bucket **NOT** have versioning turned on.
Old versions of Restic's repository files are not useful.

## Docker Hub
This image is built automatically on Docker Hub as [silintl/restic-backup-restore-b2](https://hub.docker.com/r/silintl/restic-backup-restore-b2/)
