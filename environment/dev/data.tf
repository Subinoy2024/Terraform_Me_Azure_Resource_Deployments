# Get current tenant
data "azurerm_client_config" "current" {}


# Existing Key Vault
data "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

# Secrets
data "azurerm_key_vault_secret" "vm_username" {
  name         = "vmusername"
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vmpassword"
  key_vault_id = data.azurerm_key_vault.this.id
}


