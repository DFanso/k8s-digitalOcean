terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "default" {
  name   = var.droplet_name
  region = var.region
  size   = var.size
  image  = var.image
  ssh_keys = var.ssh_keys
  vpc_uuid = var.vpc_uuid
  monitoring = var.monitoring
}

resource "digitalocean_firewall" "default" {
  name   = var.firewall_name
  droplet_ids = [digitalocean_droplet.default.id]

  dynamic "inbound_rule" {
    for_each = var.allowed_ports
    content {
      protocol   = inbound_rule.value.protocol
      port_range = inbound_rule.value.port_range
      source_addresses = ["0.0.0.0/0"]
    }
  }


  outbound_rule {
    protocol   = "tcp"
    port_range = "all"
    destination_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol   = "udp"
    port_range = "all"
    destination_addresses = ["0.0.0.0/0"]
  }


}

resource "digitalocean_project_resources" "default" {
  project = var.project_id
  resources = [
    "do:droplet:${digitalocean_droplet.default.id}"
  ]
}

output "droplet_ip" {
  value = digitalocean_droplet.default.ipv4_address
}

output "droplet_id" {
  value = digitalocean_droplet.default.id
}
