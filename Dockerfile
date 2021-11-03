FROM alpine

ENV DUPLICITY_VERSION=0.8.20 \
	PARAMIKO_VERSION=2.8.0 \
	UTILITY="gnupg curl openssh-client librsync libffi" \
	DEPS="py3-cryptography py3-pynacl py3-cffi py3-bcrypt" \
	DEPS_BUILD="gcc libffi-dev libc-dev python3-dev librsync-dev gettext"

RUN apk add -U python3 py3-pip $UTILITY $DEPS $DEPS_BUILD \
	&& pip3 install --no-cache-dir paramiko=="${PARAMIKO_VERSION}" \
	&& pip3 install --no-cache-dir duplicity=="${DUPLICITY_VERSION}" \
	&& apk del $DEPS_BUILD \
	&& pip3 list \
	&& rm -f /var/cache/apk/*

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
