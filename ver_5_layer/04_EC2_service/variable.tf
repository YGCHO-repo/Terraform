variable "region" {
  type    = string
  default = ""
}

variable "prefix" {
  type    = string
  default = ""
}


variable "tags" {
  type = map(string)
  default = {}
}

variable "add_instance" {
  description = "EC2 Create map list"
  type        = map(any)
  default = {}
}


# variable "region" {
#   type    = string
# }

# variable "prefix" {
#   type    = string
# }


# variable "tags" {
#   type = map(string)
#   default = {}
# }

# variable "add_instance" {
#   description = "EC2 Create map list"
#   type        = map(any)
#   default = {}
# }

# -----
# variable "region" { }

# variable "prefix" { }

# variable "tags" { }

# variable "add_instance" { }