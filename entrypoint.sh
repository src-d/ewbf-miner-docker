#!/bin/bash

set -e

function build_config() {
    local commands_file
    commands_file=$(mktemp)
    for var in CUDA_DEVICES \
               INTENSITY \
               TEMPLIMIT \
               PEC \
               BOFF \
               EEXIT \
               TEMPUNITS \
               LOG \
               LOGFILE \
               API_PORT \
               SERVER0 \
               PORT0 \
               SERVER1 \
               PORT1 \
               SERVER2 \
               PORT2 \
               ZCASH_WALLET \
               ZPOOL_USER
    do
        if [ ! "${!var}" ]; then
            echo "${var} not set. Exiting"
            exit 1
        fi
        echo "s/__${var}__/${!var}/g" >> $commands_file
    done

    sed -f $commands_file /miner-template.cfg > /miner.cfg
    rm -f $commands_file
    return 0
}

build_config

if [[ $# > 0 ]]; then
    exec $@
else
    exec /miner --config /miner.cfg
fi
