variable "droplet_name" {
  description = "Name for the DigitalOcean droplet"
  type = string
}

variable "region" {
  description = "Region for the DigitalOcean droplet"
  type = string
}

variable "size" {
  description = "Size of the DigitalOcean droplet"
  type = string
}

variable "image" {
  description = "Droplet image"
  type = string
}

variable "ssh_keys" {
  description = "List of SSH key fingerprints"
  type = list(string)
}

variable "firewall_name" {
  description = "Name for the firewall"
  type = string
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
  type = string
}

variable "vpc_uuid" {
  description = "DigitalOcean VPC ID"
  type = string
}

variable "monitoring" {
  description = "DigitalOcean VM Monitoring"
  type = bool
}
