provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.20.0"
    features {}

    subscription_id = "1d5e1dbd-17d7-4fc2-a3fd-7ec1f2b4e798"
    client_id       = "e1862bda-63c2-4e6a-b654-7a331ef07b1b"
    client_secret   = "vWq7Xvg3-ho-tZJebQ9eRMW2J-5dJ7Uuwb"
    tenant_id       = "505e5f9c-ce37-4f38-81c9-15e15720a73f"
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-portal-dev"
    location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-dev-eastus-001"
    address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet" {
    name                 = "snet-dev-eastus-001"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix       = "10.0.0.0/26"
}

resource "azurerm_public_ip" "pip" {
    name                         = "pip-vmportal-dev-eastus-001"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    allocation_method            = "Static"
}

resource "azurerm_lb" "lb" {
    name                = "lb-portal-dev"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    frontend_ip_configuration {
    name                 = "publicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip.id
    }
}

# resource "azurerm_lb_frontend_address_pool" "lb-pool" {
#     resource_group_name = azurerm_resource_group.rg.name
#     loadbalancer_id     = azurerm_lb.lb.id
#     name                = "FrontEndAddressPool"
# }

resource "azurerm_network_interface" "nic" {
    count               = 2
    name                = "nic-weballow-${count.index}"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_managed_disk" "dls" {
    count                = 2
    name                 = "datadisk_existing_${count.index}"
    location             = azurerm_resource_group.rg.location
    resource_group_name  = azurerm_resource_group.rg.name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = "64"
}

resource "azurerm_availability_set" "avset" {
    name                         = "avset"
    location                     = azurerm_resource_group.rg.location
    resource_group_name          = azurerm_resource_group.rg.name
    platform_fault_domain_count  = 2
    platform_update_domain_count = 2
    managed                      = true
}

resource "azurerm_virtual_machine" "vm" {
    count                 = 2
    name                  = "vmportal${count.index}"
    location              = azurerm_resource_group.rg.location
    availability_set_id   = azurerm_availability_set.avset.id
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
    vm_size               = "Standard_B1s"

    # Uncomment this line to delete the OS disk automatically when deleting the VM
    # delete_os_disk_on_termination = true

    # Uncomment this line to delete the data disks automatically when deleting the VM
    # delete_data_disks_on_termination = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "myosdisk${count.index}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    # Optional data disks
    storage_data_disk {
        name              = "datadisk_new_${count.index}"
        managed_disk_type = "Standard_LRS"
        create_option     = "Empty"
        lun               = 0
        disk_size_gb      = "64"
    }

    storage_data_disk {
        name            = element(azurerm_managed_disk.dls.*.name, count.index)
        managed_disk_id = element(azurerm_managed_disk.dls.*.id, count.index)
        create_option   = "Attach"
        lun             = 1
        disk_size_gb    = element(azurerm_managed_disk.dls.*.disk_size_gb, count.index)
    }

    os_profile {
        computer_name  = "hostname"
        admin_username = "wilman"
        admin_password = "Colombia2020!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags = {
        environment = "develop"
    }
}