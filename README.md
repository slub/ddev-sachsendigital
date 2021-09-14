# ddev-sachsendigital

> :warning: This project depends upon the `slub-web-ldp` TYPO3 extension, which is not publicly available yet.

This repository provides a [DDEV](https://ddev.readthedocs.io/)-based development environment for Sachsen.Digital.

## Quick Start

1. Clone this repository
   ```bash
   git clone https://github.com/slub/ddev-sachsendigital.git
   cd ddev-sachsendigital
   ```

1. Initialize the environment
   ```bash
   ./scripts/quickstart.sh
   ```

1. (Optional) Populate your Solr index by indexing or re-indexing sample documents
   ```bash
   ./scripts/doc-reindex.sh
   ```

1. Open the web page in your browser
   ```bash
   ddev launch
   ```

## Extension Development

This repository is configured to allow an easy local setup of Sachsen.Digital. If you would like to develop on one of the custom TYPO3 extensions, some adjustments are required.

### Pre-configured

You may use the convenience script `scripts/ext-clone.sh` to clone the extensions into a subfolder `extensions/` and reconfigure `composer.json`:

```bash
./scripts/ext-clone.sh
ddev composer update
```

### Manually

1. Clone the extension repositories somewhere.
1. If the extensions are outside of the directory tree of this repository (symlinking is not enough!), create a file `.ddev/docker-compose.mounts.yaml` like this:
   ```yaml
   version: '3.6'
   services:
     web:
       volumes:
         - /your/path/to/extensions:/var/www/extensions
   ```
   Be aware that in relative paths, "`.`" points to `.ddev/`.
1. In `composer.json`, update the `repositories` field; for example:
   ```yaml
   "repositories": {
       "kitodo-presentation": {
           "type": "path",
           "url": "/var/www/extensions/kitodo-presentation"
       },
       // ...
   }
   ```
1. (Re-)Start DDEV, then tell Composer about the changes to `composer.json`:
   ```bash
   ddev start
   ddev composer update
   ```

## URLs

- Backend Login: [https://sachsendigital.ddev.site/typo3/](https://sachsendigital.ddev.site/typo3/)
   - User: `admin`
   - Password: `adminslub`
- Solr: [http://sachsendigital.ddev.site:8983/solr](http://sachsendigital.ddev.site:8983/solr)

## Database Dump

```bash
# Cleanup running database to keep dumps tidy.
# Note that this will log you out.
./scripts/db-cleanup.sh

# Dump into `data/db.sql`
./scripts/db-export.sh
```

If you find anything in the published database dump that should not be shared, please feel free to open an issue or a pull request.

## Dependencies

- (Optional) [mkcert](https://github.com/FiloSottile/mkcert) for locally trusted TLS certificates
- [DDEV](https://sachsendigital.ddev.site)
