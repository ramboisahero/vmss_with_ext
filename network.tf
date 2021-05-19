resource "azurerm_virtual_network" "Deveops_VNET" {
  name                = "Deveops_VNET"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.devops_vmss_ado.location
  resource_group_name = azurerm_resource_group.devops_vmss_ado.name
}

resource "azurerm_subnet" "Deveops_subnet" {
  name                 = "Deveops_subnet"
  resource_group_name = azurerm_resource_group.devops_vmss_ado.name
  virtual_network_name = azurerm_virtual_network.Deveops_VNET.name
  address_prefixes     = ["10.2.2.0/24"]
}

resource "azurerm_network_security_group" "allow-ssh" {
    name                = "Devops_VM-allow-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.devops_vmss_ado.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}



