variable "context" {
  description = "The context in which this module is being applied."
  type = object({
    environment = string
  })
}
