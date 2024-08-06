output "master_ip" {
  value = module.master.droplet_ip
}

output "worker_ip" {
  value = module.worker.droplet_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "master_id" {
  value = module.master.droplet_id
}

output "worker_id" {
  value = module.worker.droplet_id
}

output "loadbalancer_ip" {
  value = module.loadbalancer.loadbalancer_ip
}

output "loadbalancer_id" {
  value = module.loadbalancer.loadbalancer_id
}