variable "context" {
  description = "The context in which this module is being applied."
  type = object({
    environment = string
  })
}

variable "network" {
  type = object({
    vpc              = any
    private_subnet   = any
    internet_gateway = any
  })
}

variable "key_name" {
  type = string
}
