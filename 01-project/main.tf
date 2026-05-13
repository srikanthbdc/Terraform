terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }

}

resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = "Denmark East"
  resource_group_name = "denmark_east-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/1d201e0e-d52e-420e-b665-bc3974b6a17f/resourceGroups/denmark_east/providers/Microsoft.Network/virtualNetworks/PROJECT-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "test-vm"
  resource_group_name = "denmark_east-rg"
  location            = "Denmark East"
  size                = "Standard_F2"
  admin_username      = "devops"
  admin_password      = "Devops123456"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]

  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_D2s_v3"
  }

  source_image_id  = "/subscriptions/1d201e0e-d52e-420e-b665-bc3974b6a17f/resourceGroups/denmark_east/providers/Microsoft.Compute/galleries/padmasrikanthiamge"
  
}