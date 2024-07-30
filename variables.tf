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
