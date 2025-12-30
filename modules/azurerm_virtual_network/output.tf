output "vnet_id" {
  value = azurerm_virtual_network.this.name
}

output "subnets" {
  value = {
    for k, v in azurerm_subnet.this :
    k => {
      id   = v.id
      cidr = v.address_prefixes[0]
    
    }
  }
}

