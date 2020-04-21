#! /usr/bin/env bash

set -e
set -x

./configure ${ZEEK_CI_CONFIGURE_FLAGS}

# TODO: not a huge fan of making this dependent on the task name. Maybe a different script
# for CentOS 7 that does this and leave the existing build.sh alone?
echo $CIRRUS_TASK_NAME
if [ "${CIRRUS_TASK_NAME}" = "centos7" ]; then
    make -j ${ZEEK_CI_CPUS} install
    tar -czf ${CIRRUS_WORKING_DIR}/build.tgz ${CIRRUS_WORKING_DIR}/install
else
    make -j ${ZEEK_CI_CPUS}
fi
