output "droplet_id" {
  value = digitalocean_droplet.default.id
}

output "droplet_ip" {
  value = digitalocean_droplet.default.ipv4_address
}
