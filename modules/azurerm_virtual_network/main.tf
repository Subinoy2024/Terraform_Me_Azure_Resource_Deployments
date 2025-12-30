

resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = var.address_space
  tags          = var.tags
}
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = "${var.name}-${each.key}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [
    cidrsubnet(
      var.address_space[0],      # Base CIDR
      each.value.newbits,        # Subnet size
      each.value.subnet_index    # Subnet number
    )
  ]
}


resource "azurerm_network_security_group" "this" {
  for_each = var.subnets

  name                = "${var.name}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.nsg_rules

    content {
      name                       = "allow-${security_rule.key}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}


resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}
