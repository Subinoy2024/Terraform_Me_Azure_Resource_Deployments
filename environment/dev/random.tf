#random string resource
resource "random_string" "random" {
  length  = 8
  upper   = false
  special = false


}

