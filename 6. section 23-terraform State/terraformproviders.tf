terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
  backend "azurerm" {
    resource_group_name = "Terraform-Backend"
    storage_account_name = "terraformbackendstate1"
    container_name = "tfstatefiles"
    key = "project1-terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "random" {

}
