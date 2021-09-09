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

## `.htaccess`

To allow TYPO3 to process requests to arbitrary subpaths (pretty URLs), URL rewriting needs to be configured. We do this by adding the TYPO3 example `.htaccess` file.

```bash
wget -O public/.htaccess https://raw.githubusercontent.com/TYPO3/typo3/v9.5.30/typo3/sysext/install/Resources/Private/FolderStructureTemplateFiles/root-htaccess
echo '!/public/.htaccess' >> .gitignore
```

## Extensions

```bash
./scripts/ext-clone.sh

echo '/extensions' >> .gitignore

ddev composer config repositories.kitodo-presentation vcs git@github.com:kitodo/kitodo-presentation.git
ddev composer config repositories.slub-web-ldp vcs git@git.slub-dresden.de:slub-webseite/slub-web-ldp.git

ddev composer require kitodo/presentation:dev-master
ddev composer require slub/slub-web-ldp:dev-master

ddev typo3cms database:updateschema
```

### In TYPO3 backend

- Create folder `Kitodo.Presentation`
- Let the `Kitodo.Presentation` extension create structures and metadata
- Open configuration modal for `dlf` extension (this is just to amend `LocalConfiguration.php`)
