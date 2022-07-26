#!/usr/bin/env sh

STATUS=0

echo "restic-backup-restore-b2: backup: Started"
echo "restic-backup-restore-b2: Backing up ${SOURCE_PATH}"

start=$(date +%s)
/usr/local/bin/restic backup --host ${RESTIC_HOST} --tag ${RESTIC_TAG} ${RESTIC_BACKUP_ARGS} ${SOURCE_PATH} || STATUS=$?
end=$(date +%s)

if [ $STATUS -ne 0 ]; then
	echo "restic-backup-restore-b2: FATAL: Backup returned non-zero status ($STATUS) in $(expr ${end} - ${start}) seconds."
	exit $STATUS
else
	echo "restic-backup-restore-b2: Backup completed in $(expr ${end} - ${start}) seconds."
fi

start=$(date +%s)
/usr/local/bin/restic forget --host ${RESTIC_HOST} ${RESTIC_FORGET_ARGS} --prune || STATUS=$?
end=$(date +%s)

if [ $STATUS -ne 0 ]; then
	echo "restic-backup-restore-b2: FATAL: Backup pruning returned non-zero status ($STATUS) in $(expr ${end} - ${start}) seconds."
	exit $STATUS
else
	echo "restic-backup-restore-b2: Backup pruning completed in $(expr ${end} - ${start}) seconds."
fi

start=$(date +%s)
/usr/local/bin/restic check || STATUS=$?
end=$(date +%s)

if [ $STATUS -ne 0 ]; then
	echo "restic-backup-restore-b2: FATAL: Repository check returned non-zero status ($STATUS) in $(expr ${end} - ${start}) seconds."
	exit $STATUS
else
	echo "restic-backup-restore-b2: Repository check completed in $(expr ${end} - ${start}) seconds."
fi

start=$(date +%s)
/usr/local/bin/restic unlock || STATUS=$?
end=$(date +%s)

if [ $STATUS -ne 0 ]; then
	echo "restic-backup-restore-b2: FATAL: Repository unlock returned non-zero status ($STATUS) in $(expr ${end} - ${start}) seconds."
	exit $STATUS
else
	echo "restic-backup-restore-b2: Repository unlock completed in $(expr ${end} - ${start}) seconds."
fi

echo "restic-backup-restore-b2: backup: Completed"
exit $STATUS
