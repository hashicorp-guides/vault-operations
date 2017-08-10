FROM krallin/ubuntu-tini:xenial

ENV TERM=ansi DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
ENV PATH /bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

COPY ./binaries/consul /usr/local/bin/consul

RUN mkdir -p /etc/hashicorp/vault
COPY ./config/etc/hashicorp/vault/config.hcl /etc/hashicorp/vault/config.hcl
COPY ./binaries/vault /usr/local/bin/vault
ENTRYPOINT ["/usr/local/bin/tini", "--", "/usr/local/bin/vault", "server", "-config", "/etc/hashicorp/vault/config.hcl"]

COPY Dockerfile /Dockerfile
