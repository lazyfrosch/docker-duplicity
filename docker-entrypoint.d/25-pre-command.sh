#!/bin/sh

set -ex

if test -n "${DUPLICITY_PRE_COMMAND}"; then
  exec ${DUPLICITY_PRE_COMMAND}
fi
