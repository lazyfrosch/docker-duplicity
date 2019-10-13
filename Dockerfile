FROM alpine

ENV DUPLICITY_VERSION=0.8.05 \
    PARAMIKO_VERSION=2.5.0 \
	UTILITY="gnupg openssh-client librsync libffi" \
    DEPS="py3-cryptography py3-pynacl py3-cffi py3-bcrypt" \
	DEPS_BUILD="gcc libffi-dev libc-dev python3-dev librsync-dev"

RUN apk add -U python3 py3-pip $UTILITY $DEPS $DEPS_BUILD \
 && ln -sv /usr/bin/pip3 /usr/local/bin/pip \
 && ln -sv /usr/bin/python3 /usr/local/bin/python \
 && pip install --no-cache-dir paramiko=="${PARAMIKO_VERSION}" \
 && pip install --no-cache-dir https://code.launchpad.net/duplicity/0.8-series/"${DUPLICITY_VERSION}"/+download/duplicity-"${DUPLICITY_VERSION}".tar.gz \
 && apk del $DEPS_BUILD \
 && pip list \
 && rm -f /var/cache/apk/*

COPY duplicity.sh /usr/local/bin/duplicity

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
