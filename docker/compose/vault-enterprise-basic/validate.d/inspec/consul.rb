consul_enterprise0_ip = %x(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' consul-enterprise0).chomp

describe http("http://#{consul_enterprise0_ip}:8500/v1/status/leader") do
  its('status') { should cmp 200 }
end

describe http("http://#{consul_enterprise0_ip}:8500/v1/status/peers") do
  its('status') { should cmp 200 }
  # How would one count the items in the array of peers?
end
