module "rgname" {
  source    = "../../modules/azurerm_resource_group"
  rgname    = "${var.rgname}-${local.resource_name_prefix}-${random_string.random.id}"
  locations = var.locations
  tags      = local.common_tags

}
module "network" {
  depends_on = [module.rgname]
  source     = "../../modules/azurerm_virtual_network"

  name     = "${var.name}-${local.resource_name_prefix}-${random_string.random.id}"
  location = var.locations
  #resource_group_name = "${var.rgname}-${local.resource_name_prefix}-${random_string.random.id}"
  resource_group_name = module.rgname.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets

  tags = local.common_tags
}


module "vm" {
  depends_on = [  module.rgname,module.network]
  source = "../../modules/azurerm_virtual_machine"

  resource_group_name = module.rgname.name
  location            = var.locations


  subnet_id = module.network.subnets["frontend"].id

  environment = local.environment
  bau         = local.bau
  timestamp   = local.timestamp

  vms = {
    app1 = {}
    app2 = {}
  }

  vmusername = data.azurerm_key_vault_secret.vm_username.value
  vmpassword = data.azurerm_key_vault_secret.vm_password.value

  tags = local.common_tags
}
