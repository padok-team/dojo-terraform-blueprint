variable "name" {
  type = string
}

variable "private_ip" {
  type = string
}

variable "is_public" {
  type = bool
}

variable "key_name" {
  type = string
}

variable "vpc" {
  type = any
}

variable "subnet" {
  type = any
}

variable "internet_gateway" {
  type = any
}
