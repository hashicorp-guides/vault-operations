storage "consul" {
  address = "consul-enterprise0:8500"
  schema = "http"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true
