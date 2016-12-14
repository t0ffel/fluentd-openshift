# Fluentd k8s Collector role

The role is responsible for deployment and re-configuration of fluentd
kubernetes collectors.

## Usage

### Deploy Fluentd node collector

To deploy fluentd node collector - simply execute the role.
In case k8s-fluentd DeploymentConfig is already deployed and has `>0` pods running,
the role will only reconfigure the k8s collector.

#### Change Fluentd image

To change image used in fluentd - please modify the value of variable
`IMAGE_PREFIX` in [fluentd-dc.yaml](templates/fluentd-dc.yaml) to
point to your Docker registry/project in your registry.

### Uninstall Fluentd node collector

To uninstall fluentd node collector - execute the role, passing variable
`logging_deploy=false`.

## Modifying configs

To modify config - change the config files in the
[k8s-collector](../../configs/k8s-collector)directory and run the role.

Alternatively you can pass `config_path` variable to the role. This variable
must contain the full path to the configs which will be converted to configmaps.

## Configmaps (particular case)
`fluntd-entrypoint-cm` configMap consists of just one file - the entrypoint
`entrypoint/fluent.conf`.
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
