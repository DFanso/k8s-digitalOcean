terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


resource "digitalocean_loadbalancer" "this" {
  name   = var.loadbalancer_name
  region = var.region
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 32149
    target_protocol = "http"
  }
  healthcheck {
    port     = 32149
    protocol = "http"
    path     = "/"
  }
  droplet_ids = var.droplet_ids
  vpc_uuid    = var.vpc_uuid
}

output "loadbalancer_ip" {
  value = digitalocean_loadbalancer.this.ip
}
