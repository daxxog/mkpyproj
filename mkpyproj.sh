#!/bin/bash
set -x
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

latest_python_minor_version() {
	curl -sL https://raw.githubusercontent.com/docker-library/python/master/${1}/bullseye/Dockerfile | grep PYTHON_VERSION | head -n 1 | sed 's/ENV PYTHON_VERSION//g; s/ //g' | tr -d '\n' | cat
}

printf "pulling template -->\n\n" && \
    try_pull_remote "env.sh" && \
    try_pull_remote ".gitignore" && \
    touch requirements.txt && \
    echo "template pulled !!"

if [ ! -f requirements.dev.txt ]; then
cat <DEVREQS | tee requirements.dev.txt
neovim
jedi
pynvim
pudb
-r requirements.txt
DEVREQS
fi

if [ ! -f .python-version ]; then
latest_python_minor_version | tee .python-version
fi
