FROM debian:jessie-backports

RUN apt-get update \
  && apt-get install -y -t jessie-backports duplicity python-setuptools \
  && apt-get install -y \
    python-swiftclient \
    mysql-client postgresql-client ldap-utils \
  && rm -rf /var/apt/lists/*

VOLUME [ "/root/.cache/duplicity" ]

COPY docker-entrypoint.sh /
COPY docker-entrypoint.d /docker-entrypoint.d
ENTRYPOINT [ "/docker-entrypoint.sh", "duplicity" ]
CMD [ "--help" ]
