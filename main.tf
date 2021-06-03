provider "azurerm" {
  #version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "devops_vmss_ado2" {
  name     = "devops_vmss_ado2"
  location = var.location
}

