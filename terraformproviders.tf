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
}

provider "azurerm" {
  features {}
}

provider "random" {

}