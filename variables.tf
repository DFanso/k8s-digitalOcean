variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "master_name" {
  description = "Name for the Kubernetes master node"
  type        = string
}

variable "worker_name" {
  description = "Name for the Kubernetes worker node"
  type        = string
}

variable "region" {
  description = "Region for the DigitalOcean droplet"
  type        = string
}

variable "master_size" {
  description = "Size of the master node"
  type        = string
}

variable "worker_size" {
  description = "Size of the worker node"
  type        = string
}

variable "image" {
  description = "Droplet image"
  type        = string
}

variable "ssh_keys" {
  description = "List of SSH key fingerprints"
  type        = list(string)
}

variable "allowed_ports" {
  description = "Ports to allow"
  type = list(object({
    protocol   = string
    port_range = string
  }))
}

variable "project_id" {
  description = "DigitalOcean project ID"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "k8s-vpc"
}

variable "ip_range" {
  description = "IP range for the VPC in CIDR notation"
  type        = string
  default     = "10.10.10.0/24"
}

variable "monitoring" {
  description = "DigitalOcean VM Monitoring"
  type        = bool
}

variable "loadbalancer_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "droplet_ids" {
  description = "List of droplet IDs to attach to the load balancer"
  type        = list(number)
}



