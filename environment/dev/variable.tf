variable "rgname" {}
variable "locations" {}


variable "vnet_address_space" {
  description = "VNET CIDR range"
  type        = list(string)
}

variable "name" {}


variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    subnet_index = number
    newbits      = number

    nsg_rules = optional(map(object({
      priority = number
      port     = string
    })), {})
  }))
}


variable "key_vault_name" {
  type = string
}

variable "key_vault_rg" {
  type = string
}
