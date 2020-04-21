#! /usr/bin/env bash

set -e
set -x

echo https://api.cirrus-ci.com/v1/artifact/github/$CIRRUS_REPO_FULL_NAME/centos7/binaries/build.tgz?branch=$CIRRUS_BRANCH
curl -X HEAD https://api.cirrus-ci.com/v1/artifact/github/$CIRRUS_REPO_FULL_NAME/centos7/binaries/build.tgz?branch=$CIRRUS_BRANCH
