# Manual Installation

This document describes how to reproduce the state of this repository.

## Install TYPO3

```bash
mkdir ddev-sachsen-digital
cd ddev-sachsen-digital

ddev config \
    --project-name=sachsen-digital \
    --project-type=typo3 \
    --docroot=public \
    --create-docroot \
    --php-version=7.3 \
    --webserver-type=apache-fpm \
    --mariadb-version=10.3

ddev start

ddev composer create "typo3/cms-base-distribution:^9.5" --prefer-dist
ddev composer config platform.php "7.3"

ddev typo3cms install:setup \
    --no-interaction \
    --database-host-name=127.0.0.1 \
    --database-port=3306 \
    --database-name=typo3 \
    --use-existing-database \
    --admin-user-name=admin \
    --admin-password=adminslub \
    --site-setup-type=site \
    --site-name="Sachsen.Digital"
```
