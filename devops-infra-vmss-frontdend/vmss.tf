resource "azurerm_resource_group" "rg" {
 name     = var.resource_group_name
 location = var.location
 tags     = var.tags
}

resource "random_string" "fqdn" {
 length  = 6
 special = false
 upper   = false
 number  = false
}

resource "azurerm_virtual_network" "vnet" {
 name                = "vnet-dev-eastus-001"
 address_space       = ["10.0.0.0/24"]
 location            = var.location
 resource_group_name = azurerm_resource_group.rg.name
 tags                = var.tags
}

resource "azurerm_subnet" "snet" {
 name                 = "snet-dev-eastus-001"
 resource_group_name  = azurerm_resource_group.rg.name
 virtual_network_name = azurerm_virtual_network.vnet.name
 address_prefix       = "10.0.0.0/26"
}

resource "azurerm_public_ip" "pip_vmportal" {
 name                         = "pip-vmportal-dev-eastus-001"
 location                     = var.location
 resource_group_name          = azurerm_resource_group.rg.name
 allocation_method = "Static"
 domain_name_label            = random_string.fqdn.result
 tags                         = var.tags
}
resource "azurerm_lb" "lb_portal" {
 name                = "lb-portal-dev"
 location            = var.location
 resource_group_name = azurerm_resource_group.rg.name

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = azurerm_public_ip.pip_vmportal.id
 }

 tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
 resource_group_name = azurerm_resource_group.rg.name
 loadbalancer_id     = azurerm_lb.lb_portal.id
 name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "lb_probe" {
 resource_group_name = azurerm_resource_group.rg.name
 loadbalancer_id     = azurerm_lb.lb_portal.id
 name                = "ssh-running-probe"
 port                = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
   resource_group_name            = azurerm_resource_group.rg.name
   loadbalancer_id                = azurerm_lb.lb_portal.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = var.application_port
   backend_port                   = var.application_port
   backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.lb_probe.id
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
 name                = "vmssportal"
 location            = var.location
 resource_group_name = azurerm_resource_group.rg.name
 upgrade_policy_mode = "Manual"

 sku {
   name     = "Standard_B1s"
   tier     = "Standard"
   capacity = 2
 }

 storage_profile_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "16.04-LTS"
   version   = "latest"
 }

 storage_profile_os_disk {
   name              = ""
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 storage_profile_data_disk {
   lun          = 0
   caching        = "ReadWrite"
   create_option  = "Empty"
   disk_size_gb   = 64
 }

 os_profile {
   computer_name_prefix = "vmlab"
   admin_username       = var.admin_user
   admin_password       = var.admin_password
   custom_data          = file("web.conf")
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 network_profile {
   name    = "terraformnetworkprofile"
   primary = true

   ip_configuration {
     name                                   = "IPConfiguration"
     subnet_id                              = azurerm_subnet.snet.id
     load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
     primary = true
   }
 }

 tags = var.tags
}

resource "azurerm_public_ip" "pip_jumpbox" {
 name                         = "jumpbox-public-ip"
 location                     = var.location
 resource_group_name          = azurerm_resource_group.rg.name
 allocation_method            = "Static"
 domain_name_label            = "${random_string.fqdn.result}-ssh"
 tags                         = var.tags
}

resource "azurerm_network_interface" "nic_jumpbox" {
 name                = "nic-weballow"
 location            = var.location
 resource_group_name = azurerm_resource_group.rg.name

 ip_configuration {
   name                          = "IPConfiguration"
   subnet_id                     = azurerm_subnet.snet.id
   private_ip_address_allocation = "dynamic"
   public_ip_address_id          = azurerm_public_ip.pip_jumpbox.id
 }

 tags = var.tags
}

resource "azurerm_virtual_machine" "vm" {
 name                  = "vmjumpbox"
 location              = var.location
 resource_group_name   = azurerm_resource_group.rg.name
 network_interface_ids = [azurerm_network_interface.nic_jumpbox.id]
 vm_size               = "Standard_B1s"

 storage_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "16.04-LTS"
   version   = "latest"
 }

 storage_os_disk {
   name              = "jumpbox-osdisk"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 os_profile {
   computer_name  = "jumpbox"
   admin_username = var.admin_user
   admin_password = var.admin_password
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 tags = var.tags
}