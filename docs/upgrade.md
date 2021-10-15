# Upgrade

## Solr configuration

If you need to update the Solr configuration after upgrading Kitodo.Presentation, you may use the following command:

```bash
ddev exec -s solr 'cp -aT "$SOLR_HOME/configsets/dlf/conf/" "$SOLR_HOME/dlfCore0/conf/"'
```

Afterwards, restart Solr and reindex the documents.
