FROM postgres:9.5

RUN apt-get update \
  && apt-get install -y cron duplicity python-swiftclient \
  && rm -rf /var/apt/lists/*

COPY pg_dump /etc/cron.d/

VOLUME [ "/root/.cache/duplicity" ]

COPY docker-entrypoint.sh /
COPY docker-entrypoint.d /docker-entrypoint.d
ENTRYPOINT [ "/docker-entrypoint.sh", "cron" ]
CMD [ "-f" ]
