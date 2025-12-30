
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "bau" {
  type = string
}

variable "timestamp" {
  type = string
}

variable "vms" {
  type = map(any)
}

variable "vmusername" {
  type = string
}

variable "vmpassword" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}
