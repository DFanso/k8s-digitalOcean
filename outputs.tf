output "master_ip" {
  value = module.master.droplet_ip
}

output "worker_ip" {
  value = module.worker.droplet_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "droplet_id" {
  value = module.worker.droplet_id
}