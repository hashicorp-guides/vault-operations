# Vault Seal Status Guide
<Use markdown when writing the RFC so you can easily copy/paste the contents into the README once complete. The below paragraphs are the minimum required scaffolding for a guide, however, you can add additional paragraphs and further detail as necessary. Provide an intro and any background context for the guide in the header.>

The goal of this guide is to help users learn how to check Vault’s seal status. There are scripts & configuration maintained in the [Vault Seal Status Guide repo](https://github.com/hashicorp-guides/vault-seal-status) used in the [steps](#steps).

## Estimated Time to Complete
<Estimated time it should take to complete>

5 minutes

## Prerequisites
<Any prerequisite guides required to complete first>

- [Vault Cluster Guide](https://www.vaultproject.io/guides/vault-cluster.html)
- [Vault Initialization Guide](https://www.vaultproject.io/guides/vault-init.html)

## Challenge
<Paragraph describing the challenge>

Given an initialized Vault cluster, you would like to determine if it is unsealed.

## Solution
<Paragraph describing the proposed solution>

By leveraging the seal-status endpoint, we can determine if Vault is unsealed and online.

## Steps
<Step-by-step instructions to solve the challenge. Not all steps will have UI, API, and CLI components.>

### Step 1: Check Seal Status
First we are going to check the seal status to determine if we need to unseal.

#### UI
##### Request
Navigate to `http://127.0.0.1:8200/ui/` in your browser.

##### Response: 200 OK

![alt text](../img/seal-status.png "Vault Seal Status")


#### cURL
##### Request
```sh
$ curl -X GET "http://127.0.0.1:8200/v1/sys/seal-status" \
    -H "X-Vault-Token: $X-Vault-Token"
```

[setup-api.sh#L2](https://github.com/hashicorp-guides/vault-seal-status/blob/master/scripts/setup-api.sh#L2)

##### Response: 200 OK
```
{"sealed":false,"t":1,"n":1,"progress":0,"nonce":"","version":"0.7.2+ent","cluster_name":"vault-cluster-7de09145","cluster_id":"c4ae0f18-4d38-704d-4884-597c6c6a51b8"}
```

#### CLI
##### Request
```sh
$ vault status
```

[setup-cli.sh#L2](https://github.com/hashicorp-guides/vault-seal-status/blob/master/scripts/setup-cli.sh#L2)

##### Response: 200 OK
```
Sealed: false
Key Shares: 1
Key Threshold: 1
Unseal Progress: 0
Unseal Nonce:
Version: 0.7.2+ent
Cluster Name: vault-cluster-7de09145
Cluster ID: c4ae0f18-4d38-704d-4884-597c6c6a51b8
```

#### Validation
Run the serverspec tests to validate you’ve successfully completed the guide.

##### Request
```sh
$ rake spec
```

[vault-seal-staus-spec.rb](https://github.com/hashicorp-guides/vault-seal-status/blob/master/spec/vault-seal-staus-spec.rb)
##### Response: 0 failures
```
/usr/bin/ruby -S rspec spec/vault.rb

Service "vault"
  should be running

Port "8200"
  should be listening

Command "curl -X GET \"http://127.0.0.1:8200/v1/sys/seal-status\""
  should match 200

Finished in 0.21091 seconds (files took 6.37 seconds to load)
3 examples, 0 failures
```

#### Reference Content
- [seal-status API](https://www.vaultproject.io/api/system/seal-status.html)

## Next Steps
- [Unseal Vault](https://github.com/hashicorp-guides/vault-unseal)
