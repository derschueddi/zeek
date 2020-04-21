#! /usr/bin/env bash

set -e
set -x

./configure ${ZEEK_CI_CONFIGURE_FLAGS}
make -j ${ZEEK_CI_CPUS} install
tar -czf ${CIRRUS_WORKING_DIR}/build.tgz ${CIRRUS_WORKING_DIR}/install
