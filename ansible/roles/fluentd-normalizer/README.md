# Fluentd normalizer role

The role is responsible for deployment and re-configuration of fluentd
normalizer.

## Usage

### Deploy Fluentd normalizer

To deploy fluentd normalizer - simply execute the role.

#### Change Fluentd image

To change image used in fluentd - please modify the value of variable
`fluentd_image` ansible variable in your playbook. By default it is defined
in [defaults/main.yaml](defaults/main.yaml).
You can point to your Docker registry/project in your registry.

### Uninstall Fluentd normalizer

TODO: not implemented yet
To uninstall fluentd normalizer - execute the role, passing variable
`fluentd_deploy=false`.

## Modifying configs

Provide absolute path to your fluentd configs via `configs_dir` ansible variable.

## Fluentd config structure

### Directories

`configs_dir` directory must only contain subdirectories which in turn
contain the actual config files.
`entrypoint` is a special directory that contains `fluent.conf` file that is the
entrypoint which includes all other configs.

When the pod is run the fluentd is executed as:

```
fluentd -c /etc/fluent/entrypoint/fluent.conf
```

ATTN: all subdirectories and files must have DNS-compliant names, as configmaps
will be derived from them.

## Configmaps
For each subdirectory of `configs_dir` a configmap will be created.

All the configmaps get mounted in the pod under `/etc/fluent`.


