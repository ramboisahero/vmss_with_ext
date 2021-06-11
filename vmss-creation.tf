resource "azurerm_linux_virtual_machine_scale_set" "buildagent-vmss" {
  name                = "buildagent-vmss"
  resource_group_name = azurerm_resource_group.devops_vmss_ado2.name
  location            = azurerm_resource_group.devops_vmss_ado2.location
  sku                 = "Standard_F2"
  instances           = var.numberOfWorkerNodes
  overprovision          = false
  single_placement_group = false

  admin_username = "azureuser"
  upgrade_mode   = "Automatic"
  #admin_password                  = var.admin_password
  #disable_password_authentication = false

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"

  }

  network_interface {
    name    = "${azurerm_resource_group.devops_vmss_ado2.name}-vmss-nic"
    primary = true

    ip_configuration {
      name      = "${azurerm_resource_group.devops_vmss_ado2.name}-ip-config"
      primary   = true
      subnet_id = azurerm_subnet.Deveops_subnet.id
    }
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "newvmext" {
  name                         = "newvmext"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.buildagent-vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  protected_settings           = <<PROT
    {
        "script": "${base64encode(templatefile("script.sh", {
          url="${var.url}"
          pat="${var.pat}"
          pool="${var.pool}"
          agent="${var.agent}"
          pyenv_cmd ="${var.pyenv_cmd}"
        }))}"
    }
  PROT
  
}

# resource "azurerm_virtual_machine_scale_set_extension" "newvmext" {
#   name                         = "newvmext"
#   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.buildagent-vmss.id
#   publisher                    = "Microsoft.Azure.Extensions"
#   type                         = "CustomScript"
#   type_handler_version         = "2.0"
#   settings = jsonencode({
#     "script" : "${base64encode(templatefile("${var.scfile}", 
# 	{
#       url="${var.url}" 
#       pat="${var.pat}"
#       pool="${var.pool}"
#       agent="${var.agent}"
#     }))}",
#     #"commandToExecute" : "bash script.sh '${var.url}' '${var.pat}' '${var.pool}' '${var.agent}'"
#   })
# }

