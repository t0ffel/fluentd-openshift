# Fluentd Node Collector role

The role is responsible for deployment and re-configuration of fluentd node
collectors.

## Usage

### Deploy Fluentd node collector

To deploy fluentd node collector - simply execute the role.
In case logging-fluentd DaemonSet is already deployed and has `>0` pods running,
the role will only reconfigure the node collector.

### Uninstall Fluentd node collector

To uninstall fluentd node collector - execute the role, passing variable
`logging_deploy=false`.

## Modifying configs

To modify config - change the config files in the
[node-collector](../../configs/node-collector)directory and run the role.

Alternatively you can pass `config_path` variable to the role. This variable
must contain the full path to the configs which will be converted to configmaps.

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
