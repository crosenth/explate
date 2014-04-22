#!/bin/bash

set -e

if [[ -z $1 ]]; then
    venv=$(basename $(pwd))-env
else
    venv=$1
fi

MISEQ_PIPELINE_DIR=$(cd $(dirname $BASH_SOURCE) && cd .. && pwd)

# create virtualenv if necessary
if [ ! -f $venv/bin/activate ]; then
    virtualenv --python /usr/local/bin/python --system-site-packages ${venv}
else
    echo "found existing virtualenv $venv"
fi

source $venv/bin/activate

cd ${MISEQ_PIPELINE_DIR}

pip install --requirement requirements.txt
