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
}

resource "digitalocean_firewall" "default" {
  name   = var.firewall_name
  droplet_ids = [digitalocean_droplet.default.id]

  dynamic "inbound_rule" {
    for_each = var.allowed_ports
    content {
      protocol   = inbound_rule.value.protocol
      port_range = inbound_rule.value.port_range
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  }
}

output "droplet_ip" {
  value = digitalocean_droplet.default.ipv4_address
}
