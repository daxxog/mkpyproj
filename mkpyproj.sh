#!/bin/bash
SOURCE_GH_REPO="daxxog/envsubst-mustache"
AT_COMMIT="caaf2b3ee50e7e1d64a6dfca0b3ef44473c24437"
PULL_FROM="https://raw.githubusercontent.com/${SOURCE_GH_REPO}/${AT_COMMIT}"

try_pull_remote() {
    if [ ! -f ${1} ]; then
        wget "${PULL_FROM}/${1}"
    else
        echo "file '${1}' already exists !"
        exit 1
    fi
}

echo "pulling template -->\n" && \
    try_pull_remote "env.sh" && \
    try_pull_remote "requirements.dev.txt" && \
    try_pull_remote ".gitignore" && \
    try_pull_remote ".python-version" && \
    echo "template pulled !!"
