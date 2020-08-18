 output "vmss_public_ip" {
     value = azurerm_public_ip.pip_vmportal.fqdn
 }
 output "jumpbox_public_ip" {
   value = azurerm_public_ip.pip_jumpbox.fqdn
}
