terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "master" {
  source        = "./modules/droplet"
  droplet_name  = var.master_name
  region        = var.region
  size          = var.master_size
  image         = var.image
  ssh_keys      = var.ssh_keys
  firewall_name = "${var.master_name}-firewall"
  allowed_ports = var.allowed_ports
}

module "worker" {
  source        = "./modules/droplet"
  droplet_name  = var.worker_name
  region        = var.region
  size          = var.worker_size
  image         = var.image
  ssh_keys      = var.ssh_keys
  firewall_name = "${var.worker_name}-firewall"
  allowed_ports = var.allowed_ports
}
