#!/bin/sh

set -e

: "${IMAGE:=lazyfrosch/duplicity}"

HOSTNAME=duplicity-test
SSH_CONFIG="$(pwd)/.ssh"

# inside container or mount
SOURCE=/var
TARGET="sftp://${SSH_USERNAME}@${SSH_SERVER}:${SSH_PORT:-22}/test"

docker run -i --rm \
  -h "${HOSTNAME}" \
  -v "${SSH_CONFIG}:/root/.ssh:ro" \
  -e "PASSPHRASE=${PASSPHRASE}" \
  --entrypoint '' \
  "${IMAGE}" \
  sh -ex <<EOF

#mkdir -p "\$HOME/.ssh"
#chmod go= "\$HOME/.ssh"
#ssh-keyscan -p "${SSH_PORT:-22}" "$SSH_SERVER" >"\$HOME/.ssh/known_hosts"

# key for duplicity
export PASSPHRASE="testtesttest"

duplicity full "${SOURCE}" "${TARGET}"
duplicity incr "${SOURCE}" "${TARGET}"
duplicity collection-status "${TARGET}"
duplicity verify "${TARGET}" "${SOURCE}"

# keep cleaning up - this will not delete the current backup
duplicity remove-older-than 0s --force "${TARGET}"
EOF

# vi: ts=2 sw=2 expandtab
