FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y software-properties-common python-software-properties \
  && add-apt-repository ppa:duplicity-team/ppa \
  &&  apt-get update \
  && apt-get install -y duplicity python-setuptools \
  && apt-get install -y \
    python-boto python-paramiko python-swiftclient python-pexpect openssh-client \
  && rm -rf /var/apt/lists/*

COPY duplicity /usr/local/bin/duplicity

# Fix ssh_paramiko_backend not to fiddle with warnings
RUN sed -i 's/warnings./# IGNORED: \0/' /usr/lib/python2.7/dist-packages/duplicity/backends/ssh_paramiko_backend.py

VOLUME [ "/root/.cache/duplicity" ]

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
