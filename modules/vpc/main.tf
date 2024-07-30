terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_vpc" "default" {
  name     = var.vpc_name
  region   = var.region
  ip_range = var.ip_range
}

output "vpc_id" {
  value = digitalocean_vpc.default.id
}
