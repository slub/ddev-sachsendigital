#!/usr/bin/env bash

# This script truncates tables that need not be exported
# within the DDEV-hosted database.

(
cat << END
UPDATE db.be_users 
SET
    userMods=NULL,
    uc='',
    lastlogin=0;

TRUNCATE TABLE db.be_sessions;

TRUNCATE TABLE db.cache_treelist;
TRUNCATE TABLE db.cf_adminpanel_requestcache;
TRUNCATE TABLE db.cf_adminpanel_requestcache_tags;
TRUNCATE TABLE db.cf_cache_hash;
TRUNCATE TABLE db.cf_cache_hash_tags;
TRUNCATE TABLE db.cf_cache_imagesizes;
TRUNCATE TABLE db.cf_cache_imagesizes_tags;
TRUNCATE TABLE db.cf_cache_pages;
TRUNCATE TABLE db.cf_cache_pages_tags;
TRUNCATE TABLE db.cf_cache_pagesection;
TRUNCATE TABLE db.cf_cache_pagesection_tags;
TRUNCATE TABLE db.cf_cache_rootline;
TRUNCATE TABLE db.cf_cache_rootline_tags;

TRUNCATE TABLE db.cf_extbase_datamapfactory_datamap;
TRUNCATE TABLE db.cf_extbase_datamapfactory_datamap_tags;

TRUNCATE TABLE db.sys_file_processedfile;

TRUNCATE TABLE db.sys_lockedrecords;

TRUNCATE TABLE db.sys_history;
TRUNCATE TABLE db.sys_log;

TRUNCATE TABLE db.sys_refindex;
END
) | ddev mysql
