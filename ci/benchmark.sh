#! /usr/bin/env bash

set -e

CENTOS7_BUILD_URL="https://api.cirrus-ci.com/v1/artifact/build/${CIRRUS_BUILD_ID}/centos8/binary/build.tgz"
B64_BUILD_URL=$(echo -n ${CENTOS7_BUILD_URL} | base64 -i -)

# Generate an HMAC digest for the path plus a timestamp to send as an authentication header. openssl outputs a
# hex string here so there's no need to base64 encode it.
TIMESTAMP=$(date +'%s')
HMAC_DIGEST=$(echo "/zeek${TIMESTAMP}" | openssl dgst -sha256 -hmac ${ZEEK_BENCHMARK_HMAC_KEY} | awk '{print $2}')

#curl -X POST -H "Zeek-HMAC: ${HMAC_DIGEST}" -H "Zeek-HMAC-Timestamp: ${TIMESTAMP}" \"http://os-perf.colo.corelight.io:8000/zeek?branch=${CIRRUS_BRANCH}\&build=${B64_BUILD_URL}\"
