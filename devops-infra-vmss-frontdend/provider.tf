provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.23.0"
    features {}

    subscription_id = "1d5e1dbd-17d7-4fc2-a3fd-7ec1f2b4e798"
    client_id       = "e1862bda-63c2-4e6a-b654-7a331ef07b1b"
    client_secret   = "vWq7Xvg3-ho-tZJebQ9eRMW2J-5dJ7Uuwb"
    tenant_id       = "505e5f9c-ce37-4f38-81c9-15e15720a73f"
}