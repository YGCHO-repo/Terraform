variable "region" {
  type    = string
  default = ""
}

variable "prefix" {
  type    = string
  default = ""
}

variable "az" {
  description = "Created EC2-Bastion AZ"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Key name to use for EC2 instance"
  type        = string
  default     = ""
}

variable "volume_size" {
  description = "The size of the volume in gigabytes"
  type        = number
}

variable "volume_type" {
  description = "The type of volume (gp2, gp3, io2, standard)"
  type        = string
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
  }
}