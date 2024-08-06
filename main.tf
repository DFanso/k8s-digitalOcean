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

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  region   = var.region
  ip_range = var.ip_range
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
  project_id    = var.project_id
  vpc_uuid      = module.vpc.vpc_id
  monitoring    = var.monitoring
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
  project_id    = var.project_id
  vpc_uuid      = module.vpc.vpc_id
  monitoring    = var.monitoring
}

locals {
  droplet_ids = concat(
    [module.master.droplet_id],
    [module.worker.droplet_id]
  )
}

module "loadbalancer" {
  source            = "./modules/loadbalancer"
  loadbalancer_name = var.loadbalancer_name
  region            = var.region
  droplet_ids       = local.droplet_ids
  vpc_uuid          = module.vpc.vpc_id

  depends_on = [module.master, module.worker]
}


