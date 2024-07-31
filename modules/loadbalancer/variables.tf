variable "loadbalancer_name" {
  default = "invabode"
  description = "The name of the load balancer"
  type        = string
}

variable "region" {
  description = "The region where the load balancer will be created"
  type        = string
}

variable "droplet_ids" {
  description = "List of droplet IDs to attach to the load balancer"
  type        = list(number)
}

variable "vpc_uuid" {
  description = "The VPC UUID to which the load balancer belongs"
  type        = string
}
