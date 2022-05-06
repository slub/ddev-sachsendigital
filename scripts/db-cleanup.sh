#!/usr/bin/env bash

# This script truncates tables that need not be exported
# within the DDEV-hosted database.

ddev typo3cms cache:flush > /dev/null

(
cat << END
UPDATE db.be_users
SET
    userMods=NULL,
    uc='',
    lastlogin=0;

TRUNCATE TABLE db.be_sessions;
TRUNCATE TABLE db.fe_sessions;

UPDATE db.sys_registry
SET entry_value=NULL
WHERE entry_namespace='core' AND entry_key LIKE 'formProtectionSessionToken:%';

TRUNCATE TABLE db.sys_file_processedfile;

TRUNCATE TABLE db.sys_lockedrecords;

TRUNCATE TABLE db.sys_history;
TRUNCATE TABLE db.sys_log;

TRUNCATE TABLE db.sys_refindex;
END
) | ddev mysql
