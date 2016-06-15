#!/bin/bash

CONSUL_BIN=/usr/local/bin/consul

# defaults
RUN_SERVER=${RUN_SERVER-false}
BOOTSTRAP_CONSUL=${BOOTSTRAP_CONSUL-false}

mkdir -p /etc/consul.d/
mkdir -p /var/consul/

${CONSUL_BIN} agent -pid-file=${PIDFILE} -config-file=/etc/consul.json -config-dir=/etc/consul.d
