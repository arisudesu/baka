#!/bin/sh
set -x

BAKA_MODULE="$1"
BAKA_MODNAME=$(basename "$BAKA_MODULE")

export BAKA_MODULE
export BAKA_MODNAME

_conf_d=${BAKA_MODULE%/*}/../conf.d
_c=${BAKA_MODNAME%%.*}

if [ -n "$_c" -a "$_c" != "$RC_SVCNAME" ]; then
	source "$_conf_d/$_c" || true
fi

source "$_conf_d/$RC_SVCNAME" || true

unset _c
unset _conf_d

default_backup_pre() {
	return 0
}

default_backup_post() {
	return 0
}

backup_pre() {
	default_backup_pre
}

backup_post() {
	default_backup_post
}

source "$BAKA_MODULE"

backup_pre || exit $?

[ -n "$backup_paths" ] && \
	env RESTIC_PASSWORD=0000 \
		RESTIC_REPOSITORY=/mnt/f/BACKUPS/baka \
	restic backup $backup_paths

backup_post || exit $?
