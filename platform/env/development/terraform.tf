
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg.."
#     storage_account_name = "sa.."
#     container_name       = "tfstate"
#     key                  = "development" # refers to the file name
#   }
# }


terraform {
  required_version = ">= 1.4.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.113.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.53.0"
    }
  }
}
