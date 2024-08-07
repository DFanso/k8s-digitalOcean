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
  # Frontend forwarding rule
  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 32001
    target_protocol = "http"
  }

  # API forwarding rule /api
  forwarding_rule {
    entry_port     = 32000
    entry_protocol = "http"
    target_port    = 32000
    target_protocol = "http"
  }
  healthcheck {
    port     = 32000
    protocol = "http"
    path     = "/api"
  }
  droplet_ids = var.droplet_ids
  vpc_uuid    = var.vpc_uuid
}

output "loadbalancer_ip" {
  value = digitalocean_loadbalancer.this.ip
}

output "loadbalancer_id" {
  value = digitalocean_loadbalancer.this.id
}