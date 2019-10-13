#!/bin/sh

set -e

IMAGE=lazyfrosch/duplicity
VOLUME=duplicity_test
HOSTNAME=duplicity-test

if [ -n "$1" ]; then
  IMAGE="$1"
fi

duplicity() {
  docker run -it --rm \
    -h "${HOSTNAME}" \
    -v "${VOLUME}:/backup" \
    -e "PASSPHRASE=${PASSPHRASE}" \
    lazyfrosch/duplicity \
    "$@"
}

set -x

export PASSPHRASE="testtesttest"

docker volume rm "$VOLUME" >/dev/null 2>/dev/null || true
docker volume create "$VOLUME" >/dev/null

duplicity full /usr file:///backup
duplicity incr /usr file:///backup
duplicity collection-status file:///backup
duplicity verify file:///backup /usr

docker volume rm "$VOLUME" >/dev/null

# vi : ts=2 sw=2 expandtab
