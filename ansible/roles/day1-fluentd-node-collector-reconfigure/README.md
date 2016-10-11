# Fluentd Collector reconfiguration role

The role is responsible for configuration and re-configuration of fluentd node
collectors.

## Modifying configs

To modify config - change the config files in the [files](files) directory and
run the role.

## Configmaps
`fluntd-entrypoint-cm` configMap consists of just one file - the entrypoint
`entrypoint/fluent.conf`.
`journal-dir` configMap consists of the files in the directory `journal/`.
`input-dir` configMap consists of the files in the directory `input/`

All the configmaps get mounted in the pod under `/etc/fluent`.

## Fluentd config structure

### Directories

`input` is a special directory that contains all `<source>` sections.
`entrypoint` is a special directory that contains `fluent.conf` file that is the
entrypoint which includes all other configs.

When the pod is run the fluentd is executed as:

```
fluentd -c /etc/fluent/entrypoint/fluent.conf
```

Other directories correspond to the names of Fluentd labels.

### Flow

Input sources must have labels.
Structurally different sources must have different labels.
The entry point will include `base.conf` file from the respective label
directory.
The respective `base.conf` file includes the real config files - filters and
matches from the same directory.
