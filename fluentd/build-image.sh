#!/bin/sh

set -ex
prefix=${PREFIX:-${1:-viaq/}}
version=${VERSION:-${2:-latest}}
docker build -t "${prefix}fluentd-logging:${version}" .
