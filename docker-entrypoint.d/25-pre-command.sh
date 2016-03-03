#!/bin/sh

if test -n "${DUPLICITY_PRE_COMMAND}"; then
  $(${DUPLICITY_PRE_COMMAND})
fi
