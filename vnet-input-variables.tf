variable "vnet_name" {
  description = "Virtual network name"
  type = string
  default = "vnet-default"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

# Web Subnet

variable "web_subnet_name" {
  description = "Web Subnet name"
  type = string
  default = "websubnet"
}

variable "web_subnet_address" {
  description = "Web subnet address"
  type = list(string)
  default = [ "10.0.1.0/16" ]
}

# App Subnet

variable "app_subnet_name" {
  description = "app Subnet name"
  type = string
  default = "appsubnet"
}

variable "app_subnet_address" {
  description = "app subnet address"
  type = list(string)
  default = [ "10.0.11.0/16" ]
}

# DB Subnet

variable "db_subnet_name" {
  description = "db Subnet name"
  type = string
  default = "dbsubnet"
}

variable "db_subnet_address" {
  description = "db subnet address"
  type = list(string)
  default = [ "10.0.21.0/16" ]
}

# Bastion Subnet

variable "bastion_subnet_name" {
  description = "bastion Subnet name"
  type = string
  default = "bastionsubnet"
}

variable "bastion_subnet_address" {
  description = "bastion subnet address"
  type = list(string)
  default = [ "10.0.100.0/16" ]
}