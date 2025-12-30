rgname    = "softnec"
locations = "uk west"

vnet_address_space = ["58.0.0.0/8"]
name               = "blr"

subnets = {
  frontend = {
    subnet_index = 0
    newbits      = 8
    nsg_rules = {
      http = {
        priority = 101
        port     = "80"
      }
      https = {
        priority = 110
        port     = "443"
      }
      ssh = {
        priority = 100
        port     = "22"
      }
    }
  }

  backend = {
    subnet_index = 1
    newbits      = 8
    nsg_rules = {
      http = {
        priority = 101
        port     = "80"
      }
      https = {
        priority = 110
        port     = "443"
      }
      ssh = {
        priority = 100
        port     = "22"
      }
    }
  }

  #  forntend2= {
  #   subnet_index = 2
  #   newbits      = 11
  #   nsg_rules = {
  #     http = {
  #       priority = 101
  #       port     = "80"
  #     }
  #     https = {
  #       priority = 110
  #       port     = "443"
  #     }
  #      ssh = {
  #       priority = 100
  #       port     = "22"
  #     }
  #   }
  # }
}


key_vault_name = "softtechkeyvault"
key_vault_rg   = "Glabal_key"
