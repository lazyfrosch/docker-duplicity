FROM alpine

ENV DUPLICITY_VERSION=0.8.05 \
	UTILITY="gnupg openssh-client librsync" \
    DEPS="py3-paramiko" \
	DEPS_BUILD="gcc libc-dev python3-dev librsync-dev"

RUN apk add -U python3 py3-pip $UTILITY $DEPS $DEPS_BUILD \
 && ln -sv /usr/bin/pip3 /usr/local/bin/pip \
 && ln -sv /usr/bin/python3 /usr/local/bin/python \
 && pip install --no-cache-dir https://code.launchpad.net/duplicity/0.8-series/"${DUPLICITY_VERSION}"/+download/duplicity-"${DUPLICITY_VERSION}".tar.gz \
 && apk del $DEPS_BUILD \
 && pip list \
 && rm -f /var/cache/apk/*

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
