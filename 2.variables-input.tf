variable "business" {
  description = "This is business division of large Infra"
  type        = string
  default     = "sap"
}

variable "environment" {
  description = "This the environment used for prefix"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "rg-default"
}

variable "location" {
  description = "This is belong to dev location"
  type        = string
  default     = "eastus2"
}

variable "source_address_prefix" {
  description = "My vodafone public IP"
  type        = string
  default     = "193.237.208.0"
}