variable "name" {
  type = string
  
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "subnets" {
  description = "Subnet configuration using cidrsubnet"
  type = map(object({
    subnet_index = number
    newbits      = number

    nsg_rules = optional(map(object({
      priority = number
      port     = string
    })), {})
  }))
}
