provider "google" {
  credentials = "${file("../accounts.json")}"
  project     = "lynda"
  region      = "us-west1"
}

provider "aws" {
  region = "us-west-2"
}

provider "azurerm" {
  subscription_id = "0"
  client_id       = "1"
  client_secret   = "1"
  tenant_id       = "1"
}
