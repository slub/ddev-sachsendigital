# ddev-sachsendigital

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
   Composer also supports using wildcards:
   ```yaml
   "repositories": {
       "local": {
           "type": "path",
           "url": "/var/www/extensions/*"
       },
       // ...
   }
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
- XHProf (if enabled): [https://sachsendigital.ddev.site/xhprof/](https://sachsendigital.ddev.site/xhprof/)

### Access Within Local Network

To make the site accessible on your local network—e.g., to test it on a mobile device—, one option is to expose the web container:

- Set a new base URL in [config/sites/main/config.yaml](config/sites/main/config.yaml):
  ```yaml
  base: 'http://<local-ip-address>:8080'
  ```

- Make the web container reachable, then restart:
  ```bash
  ddev config --host-webserver-port=8080 --bind-all-interfaces  # .ddev/config.yaml
  ddev restart
  ddev typo3cms cache:flush
  ```

Some more options are described in the [official documentation](https://ddev.readthedocs.io/en/stable/users/topics/sharing/).

## Performance

DDEV comes bundled with XHProf, which may be used to profile web requests and CLI commands.

1. Enable/disable XHProf:
   ```bash
   ddev xhprof on
   ddev xhprof off
   ```

1. Profiling results are stored in `.ddev/xhprof/*.xhprof` and may be browsed on [http://sachsendigital.ddev.site:8983/solr](http://sachsendigital.ddev.site:8983/solr).

   Call `set_xhprof_namespace("...")` (defined in `.ddev/xhprof_prepend.php`) within the application to set a display name for the result list.

1. CLI commands: When the command is aborted via Ctrl-C (SIGINT), the shutdown handler is not called and results are not saved. To evade this, call `sxnd_sigint()` at the start of the command, and regularly call `pcntl_signal_dispatch()` within the command's execution.

## Database Dump

You may use the utility script `db-precommit.sh` to cleanup the database and export a dump to `data/db.sql`. Note that doing this will log you out.

```bash
./scripts/db-precommit.sh
```

If you find anything in the published database dump that should not be shared, please feel free to open an issue or a pull request.

## Dependencies

- (Optional) [mkcert](https://github.com/FiloSottile/mkcert) for locally trusted TLS certificates
- [DDEV](https://sachsendigital.ddev.site)
