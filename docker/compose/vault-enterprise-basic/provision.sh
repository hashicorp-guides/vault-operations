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

echo "Provisioning Vault Enterprise via Docker Compose..."
(set -x ; cd docker/compose/vault-enterprise-basic && docker-compose up --build -d)

popd > /dev/null 2>&1
