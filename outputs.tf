output "master_ip" {
  value = module.master.droplet_ip
}

output "worker_ip" {
  value = module.worker.droplet_ip
}
