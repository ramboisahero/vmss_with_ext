resource "azurerm_public_ip" "mybastion_pub_ip" {
  name                = "mybastion_pub_ip"
  location            = azurerm_resource_group.devops_vmss_ado2.location
  resource_group_name = azurerm_resource_group.devops_vmss_ado2.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "mybastion" {
  name                = "mybastion"
  location            = azurerm_resource_group.devops_vmss_ado2.location
  resource_group_name = azurerm_resource_group.devops_vmss_ado2.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Deveops_subnet2.id
    public_ip_address_id = azurerm_public_ip.mybastion_pub_ip.id
  }
  }
  