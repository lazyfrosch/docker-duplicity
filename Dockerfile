FROM debian:stretch

RUN echo "deb http://deb.debian.org/debian stretch-backports main" >/etc/apt/sources.list.d/backports.list \
 && apt-get update \
 && apt-get install -t stretch-backports -y duplicity python-paramiko openssh-client \
 && rm -rf /var/apt/lists/*

COPY duplicity /usr/local/bin/duplicity

# Fix ssh_paramiko_backend not to fiddle with warnings
#RUN sed -i 's/warnings./# IGNORED: \0/' /usr/lib/python2.7/dist-packages/duplicity/backends/ssh_paramiko_backend.py

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
