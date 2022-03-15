#!/bin/sh

BASE=${GITHUB_WORKSPACE}/addon-hyperhdr

FILE="${BASE}/config.json"
CURRENT="$(jq -r ".version" $FILE)"

echo "VERSION=${CURRENT}" >> $GITHUB_ENV

REPO="https://github.com/awawa-dev/HyperHDR.git"
RELEASE="$(git ls-remote --sort='v:refname' --tags ${REPO} | cut -d/ -f3- | tail -n1)"

echo "RELEASE=${RELEASE}" >> $GITHUB_ENV

if [ "${CURRENT}" != "${RELEASE}" ]; then
    jq ".version=\"${RELEASE}\"" $FILE > $FILE.tmp
    mv $FILE.tmp $FILE
fi
