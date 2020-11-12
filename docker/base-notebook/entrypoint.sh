#!/bin/bash

set -ex

export PANGEO_ENV="base"
if ! [[ -z "${PANGEO_SCRATCH_PREFIX}" ]] && ! [[ -z "${JUPYTERHUB_USER}" ]]; then
      export PANGEO_SCRATCH="${PANGEO_SCRATCH_PREFIX}/${JUPYTERHUB_USER}/"
      fi

if [ -n "$LIVY_ENDPOINT" ]; then
    sed -i "s|http://localhost:8998|$LIVY_ENDPOINT|g" /home/$NB_USER/.sparkmagic/config.json
fi

exec start-notebook.sh "$@"
