terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "rg-dev-todoapp"
    storage_account_name  = "sagithub"
    container_name        = "tfstate"
    key                   = "dev.tfstate"
    
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9f199aee-1ad7-464f-bd74-4b88ef990086"
}