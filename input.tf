variable "vpc_cidr" {
  default = "172.30.0.0/16"
  description = "A network for VPC."
}

variable "networks_space" {
  type = "string"
  default = 10
  description = "Maximum number of DMZ networks and the number of networks preceding the Resource networks"
}

variable "zones" {
  type = "list"
  description = "List of available zones."
}

variable "environment" {
  type = "string"
  description = "Environment name."
}

variable "managed_by" {
  type = "string"
  default = "Terraform"
  description = "The name of the resource management unit and tools eg. 'TeamName | Terraform'."
}

variable "network_size" {
  type = "string"
  default = 8
  description = "Number of bits per network."
}