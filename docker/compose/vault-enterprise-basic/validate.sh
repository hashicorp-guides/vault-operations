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

function consul_enterprise0_ip() {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
}

printf "\n>>>> Validating Vault Enterprise via InSpec...\n"
export RUBYOPT=-W0 # Dammit, gem. Shut up.
( printf "\n>>>> Validating containers..." && \
      inspec exec docker/compose/vault-enterprise-basic/validate.d/inspec/containers.rb && \
      printf "\n>>>> Validating Consul..." && \
      inspec exec docker/compose/vault-enterprise-basic/validate.d/inspec/consul.rb && \
      printf "\n>>>> Validating Vault..." && \
      inspec exec docker/compose/vault-enterprise-basic/validate.d/inspec/vault.rb)

popd > /dev/null 2>&1
