variable "managers" {
  description = "Count of manager nodes"
  type        = number
  default     = 1
}

variable "workers" {
  description = "Count of worker nodes"
  type        = number
  default     = 1
}

variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}
