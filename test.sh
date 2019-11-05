#!/bin/sh

set -e

IMAGE=lazyfrosch/duplicity
VOLUME=duplicity_test
HOSTNAME=duplicity-test
TARGET=file:///backup

if [ -n "$1" ]; then
  IMAGE="$1"
fi

if [ -n "$2" ]; then
  TARGET="$2"
fi

duplicity() {
  docker run -it --rm \
    -h "${HOSTNAME}" \
    -v "${VOLUME}:/backup" \
    -e "PASSPHRASE=${PASSPHRASE}" \
    "${IMAGE}" \
    "$@"
}

set -x

export PASSPHRASE="testtesttest"

docker volume rm "$VOLUME" >/dev/null 2>/dev/null || true
docker volume create "$VOLUME" >/dev/null

duplicity full /usr "${TARGET}"
duplicity incr /usr "${TARGET}"
duplicity collection-status "${TARGET}"
duplicity verify "${TARGET}" /usr

docker volume rm "$VOLUME" >/dev/null

# vi : ts=2 sw=2 expandtab
