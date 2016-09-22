# Fluentd logger

This repo is a variant of [Origin Aggregated Logging](https://github.com/openshift/origin-aggregated-logging).
It contains the image definitions of the components of the light-weight logging
stack as well as tools for building and deploying them.

The assumption is that we're using external ElasticSearch and visualization tools.

## Components

### Fluentd node collector

Fluentd is responsible for gathering log entries from nodes, enriching
them with metadata, and feeding them into the normalizer.

### Fluentd normalizer

Fluentd normalizer is responsible for aggregation of logs from node collectors,
normalizing them and forwarding to ElasticSearch.

### Fluentd kubernetes collector

Fluentd collector that is responsible for collection of logs from Kubernetes/ OpenShift.

### Deployer

Template and Ansible playbook to deploy all of the above.
