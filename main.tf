variable "client_secret" {
}
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.20.0"
    features {}

    subscription_id = "1d5e1dbd-17d7-4fc2-a3fd-7ec1f2b4e798"
    client_id       = "e1862bda-63c2-4e6a-b654-7a331ef07b1b"
    client_secret   = var.client_secret
    tenant_id       = "505e5f9c-ce37-4f38-81c9-15e15720a73f"
}

resource "azurerm_resource_group" "myterraformgroup" {
    name     = "rg-dev-front-portal"
    location = "eastus"

    tags = {
        project = "Vtapp DevOps"
        environment = "Development"
        unity = "Dev"
        component = "Front-End"
        type = "Infra-base"       
    }
}