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

printf "\n>>>> Validating the Docker host...\n"

(set -x; \
    RUBYOPT=-W0 inspec exec vms/dockerhost/validate.d/inspec)

popd -n > /dev/null 2>&1
