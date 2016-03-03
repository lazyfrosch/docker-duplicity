#!/bin/sh

if test -n "${DUPLICITY_PRE_COMMAND}"; then
  eval ${DUPLICITY_PRE_COMMAND}
fi
