#! /usr/bin/env bash

set -e
set -x
du -sh ${CIRRUS_WORKING_DIR}/build.tgz
