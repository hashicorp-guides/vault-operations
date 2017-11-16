# coding: utf-8
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

ENV['VAGRANT_NO_COLOR'] = 'true'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "dockerhost", autostart: true, primary: true do |dockerhost|
    dockerhost.vm.box = "ubuntu/xenial64"
    dockerhost.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    dockerhost.vm.network "forwarded_port", guest: 8500, host: 8500 # consul/consul-ui
    dockerhost.vm.network "forwarded_port", guest: 8200, host: 8200 # vault/vault-ui

    dockerhost.vm.provision "docker" do |docker|
    end  

    dockerhost.vm.provision "shell", keep_color: false, run: "always", path: "vms/dockerhost/provision.sh"
    dockerhost.vm.provision "shell", keep_color: false, run: "always", path: "vms/dockerhost/validate.sh"
    
    dockerhost.vm.provision "shell", keep_color: false, run: "always", path: "docker/compose/vault-enterprise-basic/provision.sh"
    dockerhost.vm.provision "shell", keep_color: false, run: "always", path: "docker/compose/vault-enterprise-basic/validate.sh"

    $post_up_message = <<POST_UP
If you see a bunch of successful tests above, congrats you have a Vault demo enviornment.
Please check:

https://github.com/hashicorp-guides/vault-operations

for more information. You can access the Consul and Vault Enterprise UI's at:

http://localhost:8500 # Consul
http://localhost:8200 # Vault

Enjoy!

                                - HashiCorp Solutions Engineering
POST_UP

    dockerhost.vm.post_up_message = $post_up_message
  end
end
