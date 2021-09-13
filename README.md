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

1. Open the web page in your browser
   ```bash
   ddev launch
   ```

## URLs

- Backend Login: [https://sachsendigital.ddev.site/typo3/](https://sachsendigital.ddev.site/typo3/)
   - User: `admin`
   - Password: `adminslub`
- Solr: [http://sachsendigital.ddev.site:8983/solr](http://sachsendigital.ddev.site:8983/solr)

## Database Dump

You may use `scripts/db-export.sh` to dump the database into a plain text file. Please cleanup the dump in case you would like to commit a new version:

- Before creating the dump:
  - Flush all cashes in the TYPO3 backend.
  - Reset backend user preferences.
- Usually, changes to `be_users` do not need to be committed.
- Remove inserts into, and changes to `AUTO_INCREMENT` for, the following tables:
  - `be_sessions`
  - `sys_log`
  - `sys_history`
  - `sys_refindex`
- Remove timestamp at the end of the dump.

Also, if you find anything in the published database dump that you feel should not be shared, feel free to open an issue or a pull request.

## Dependencies

- (Optional) [mkcert](https://github.com/FiloSottile/mkcert) for locally trusted TLS certificates
- [DDEV](https://sachsendigital.ddev.site)
