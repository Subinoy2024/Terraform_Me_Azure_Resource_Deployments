locals {
  bau         = "devops"
  environment = "dev"
  country     = "usa"

  timestamp = formatdate("YYYY-MM-DD-HH-mm", timestamp())

  resource_name_prefix = "${local.environment}-${local.bau}"

  common_tags = {
    bau         = local.bau
    environment = local.environment
  }
}
