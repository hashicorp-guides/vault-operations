#!/bin/bash

pushd `pwd` > /dev/null 2>&1
cd /vagrant || cd "$(dirname $0)/../../"

function onerr {
    echo "Executing cleanup on failure..."
    popd > /dev/null 2>&1 || true
    exit -1
}
trap onerr ERR

set -u

echo "Provisioning the Docker host..."

which git > /dev/null 2>&1 || \
    (echo "Installing required packages..."; set -x; \
     apt-get update && apt-get install -y git)

which inspec > /dev/null 2>&1 || \
    (echo "Installing Chef Inspec for system validation..."; set -x; \
     curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec && /opt/inspec/embedded/bin/gem install rake)

(echo "Make dockerd available on all tcp/2375 on all interfaces..."; set -x; \
    mkdir -p /etc/systemd/system/docker.service.d && \
    printf "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375\n" > /etc/systemd/system/docker.service.d/10-listen.conf && \
    systemctl daemon-reload && \
    service docker restart)

which docker-compose > /dev/null 2>&1 || \
    (echo "Installing Docker Compose..."; set -x;
     wget -c -q -O /usr/local/bin/docker-compose -c https://github.com/docker/compose/releases/download/1.14.0/docker-compose-Linux-x86_64 && \
     chmod +x /usr/local/bin/docker-compose)

popd > /dev/null 2>&1
