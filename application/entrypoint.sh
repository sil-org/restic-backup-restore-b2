#!/usr/bin/env sh

STATUS=0

case "${FSBACKUP_MODE}" in
	init|backup|restore)
		/data/${FSBACKUP_MODE}.sh || STATUS=$?
		;;
	*)
		echo restic-backup-restore-b2: FATAL: Unknown FSBACKUP_MODE: ${FSBACKUP_MODE}
		exit 1
esac

if [ $STATUS -ne 0 ]; then
	echo restic-backup-restore-b2: Non-zero exit: $STATUS
fi

exit $STATUS
