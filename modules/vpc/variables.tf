variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "region" {
  description = "Region for the DigitalOcean VPC"
  type = string
}

variable "ip_range" {
  description = "IP range for the VPC in CIDR notation"
  type = string
}
