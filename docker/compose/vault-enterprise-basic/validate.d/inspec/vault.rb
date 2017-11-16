vault_nodes = %x(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq --filter='name=vault-enterprise')).split

vault_nodes.each do |node|
  describe http("http://#{node}:8200/v1/sys/leader") do
    its('status') { should cmp 503 }
  end
end
