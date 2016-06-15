#!/bin/bash

# Consul defaults
# CONSUL_BIN=/usr/local/bin/consul

CONSUL_PID_FILE=/var/run/consul.pid
CONSUL_CFG_FILE=/etc/consul.json
CONSUL_CFG_DIR=/etc/consul.d

RUN_SERVER=${RUN_SERVER-false}
BOOTSTRAP_CONSUL=${BOOTSTRAP_CONSUL-false}

mkdir -p ${CONSUL_CFG_DIR}
mkdir -p /var/consul/

consul agent -pid-file=${CONSUL_PID_FILE} -config-file=${CONSUL_CFG_FILE} -config-dir=${CONSUL_CFG_DIR} -data-dir ${CONSUL_TMP_DIR}
