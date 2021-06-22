variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  type    = list(any)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "avail_zone" {
  type    = list(any)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "public_subnet_names" {
  type    = list(any)
  default = ["Public-Subnet-1", "Public-Subnet-2"]
}

variable "private_subnet_names" {
  type    = list(any)
  default = ["Private-Subnet-1", "Private-Subnet-2"]
}

variable "tags" {}

variable "vpc_id" {}