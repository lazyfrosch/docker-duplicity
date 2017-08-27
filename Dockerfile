FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y software-properties-common python-software-properties \
  && add-apt-repository ppa:duplicity-team/ppa \
  &&  apt-get update \
  && apt-get install -y duplicity python-setuptools \
  && apt-get install -y \
    python-boto python-paramiko python-swiftclient python-pexpect openssh-client \
  && rm -rf /var/apt/lists/*

# disable FutureWarning for duplicity
RUN sed -i '1 s~/python~\0 -Wignore~' /usr/bin/duplicity

VOLUME [ "/root/.cache/duplicity" ]

ENTRYPOINT [ "duplicity" ]
CMD [ "--help" ]
