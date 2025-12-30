resource "azurerm_network_interface" "this" {
  for_each = var.vms

  name                = "${var.environment}-${var.bau}-vm-${substr(base64encode(each.key), 0, 6)}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(
    var.tags,
    {
      module     = "linux_vm"
      created_on = var.timestamp
    }
  )
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each = var.vms

  name                = "${var.environment}-${var.bau}-vm-${substr(base64encode(each.key), 0, 6)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"

  admin_username = var.vmusername
  admin_password = var.vmpassword
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id
  ]

  custom_data = base64encode(
    templatefile("${path.module}/cloud-init.yaml", {})
  )

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = merge(
    var.tags,
    {
      module     = "linux_vm"
      created_on = var.timestamp
    }
  )
}
