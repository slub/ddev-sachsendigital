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

## cHash

Tolerate cHash errors, which is necessary when URLs containin a `tx_dlf[id]` parameter are generated on the client.

```bash
ddev typo3cms configuration:set FE/pageNotFoundOnCHashError 0
```

## LFEditor

For editing translation files, you may install LFEditor.

```bash
ddev composer require sgalinski/lfeditor "^6.0"
ddev typo3cms database:updateschema
```

Optionally, set view languages in the extension configuration.

## Extensions

```bash
./scripts/ext-clone.sh

echo '/extensions' >> .gitignore

ddev composer config repositories.kitodo-presentation vcs https://github.com/kitodo/kitodo-presentation.git
ddev composer config repositories.slub-digitalcollections vcs https://github.com/slub/slub_digitalcollections.git
ddev composer config repositories.slub-web-sachsendigital vcs https://github.com/slub/slub_web_sachsendigital.git

ddev composer require kitodo/presentation:dev-master
ddev composer require slub/slub-digitalcollections:dev-master
ddev composer require slub/slub-web-sachsendigital:dev-master

ddev typo3cms database:updateschema
```

### In TYPO3 backend

- Create folder `Kitodo.Presentation`
- Let the `Kitodo.Presentation` extension create structures and metadata
- Open configuration modal for `dlf` extension (this is just to amend `LocalConfiguration.php`)
- In List module of root page, add the following data format:
  - Format Name: `SLUB`
  - Root Element: `slub`
  - Namespace URI: `http://slub-dresden.de`

## Solr

- Adopt the Solr recipe file from DDEV:
  ```bash
  wget -O .ddev/docker-compose.solr.yaml https://raw.githubusercontent.com/drud/ddev/v1.18.0-rc1/pkg/servicetest/testdata/TestServices/docker-compose.solr.yaml
  sed -i 's@^      - ./solr:/solr-conf@      - ./solr/configsets:/var/solr/data/configsets\n      - ./solr/contrib/ocrsearch:/opt/solr/contrib/ocrsearch@g' .ddev/docker-compose.solr.yaml
  sed -i 's@solr-precreate dev /solr-conf@solr-precreate dlfCore0 /var/solr/data/configsets/dlf@g' .ddev/docker-compose.solr.yaml
  ```

- Copy configset from `kitodo-presentation` repository to `.ddev/solr`:
  ```bash
  mkdir -p .ddev/solr
  cp -a $KITODO_PRESENTATION/Configuration/ApacheSolr/configsets .ddev/solr
  ```

### In TYPO3 backend

- Open `Kitodo.Presentation` folder in *New Tenant* tab and generate an entry for the Solr core.
- In *Solr* tab of `dlf` extension configuration, change Solr Server Host from "localhost" to "solr".
- In *Template* tab, set the following constants on the root page:
  - `config.kitodo.solr.host = http://solr:8983/solr`
  - `config.solrCore = 1`
- In *List* tab, open the `Kitodo.Presenation` folder and switch to `Solr Core (PID 2)`. Enter "dlfCore0" as Solr Core.

## Import Metadata and Structure Records

- Clear existing metadata and structure records, e.g. by truncating (in phpMyAdmin or via `ddev mysql`):
  - `tx_dlf_metadata`
  - `tx_dlf_metadataformat`
  - `tx_dlf_structures`
- In TYPO3 backend, import into the `Kitodo.Presentation` folder:
  - `data/metadata.xml`
  - `data/structures.xml`

## Add Sample Documents

- Fetch URLs of sample documents from an existing Solr server:
  ```bash
  ./scripts/doc-list.sh <solr-base-url>
  ```

- Index sample documents:
  ```bash
   ./scripts/doc-index.sh data/ldp_bacharchiv
   ./scripts/doc-index.sh data/ldp_stadtarchiv_dresden
   ./scripts/doc-index.sh data/ldp_stuhlbaumuseum
   ```
