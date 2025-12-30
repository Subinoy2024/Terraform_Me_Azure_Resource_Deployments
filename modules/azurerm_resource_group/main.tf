resource "azurerm_resource_group" "rgname"{
    name= var.rgname
    location= var.locations
    tags= var.tags
}
