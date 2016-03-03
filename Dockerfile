FROM debian:stretch

RUN apt-get update \
  && apt-get install -y duplicity python-swiftclient postgresql-client \
  && rm -rf /var/apt/lists/*

VOLUME [ "/root/.cache/duplicity" ]

COPY docker-entrypoint.sh /
COPY docker-entrypoint.d /docker-entrypoint.d
ENTRYPOINT [ "/docker-entrypoint.sh", "duplicity" ]
CMD [ "--help" ]
