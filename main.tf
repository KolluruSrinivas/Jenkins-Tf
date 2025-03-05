terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
}



provider "azurerm" {
  client_id       = "69284371-215c-4646-83c8-d8e3c62796a9"
  client_secret   = "Gzs8Q~uw7xu_YINwBqiMFBRutGul_eaq0sXtPant"
  tenant_id       = "ba61a0f0-dce9-4958-bf67-58e0ff045ad2"
  subscription_id = "8258e319-97da-4600-a76c-49edbf93df29"

features {}

}

resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "EastUS"
}

# Create Virtual Network 
resource "azurerm_virtual_network" "vnet1" {
  name                = "my-vnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.10.0.0/16"]
}

#Create a subnet
resource "azurerm_subnet" "subnet1" {
    name = "subnet1-subnet"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name =azurerm_virtual_network.vnet1.name
    address_prefixes = ["10.10.1.0/24"]
  
}


resource "azurerm_network_interface" "nf1" {
  name                = "nf1-nic"
  location            = "EastUS"
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id 
    private_ip_address_allocation = "Dynamic"
  }
}



# Create Windows Virtual Machine

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "mywinvm"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "Srinivas@1983"  # Use a more secure password in production
  network_interface_ids = [
    azurerm_network_interface.nf1.id,
  ]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = "dev"
  }
}
