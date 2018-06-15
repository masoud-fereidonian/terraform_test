resource "google_compute_network" "our_development_network" {
  name                    = "devnetwork"
  auto_create_subnetworks = false
}

resource "aws_vpc" "environment_example_two" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    name = "Terrafrom-test"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block        = "${cidrsubnet(aws_vpc.environment_example_two.cidr_block, 3, 1)}"
  vpc_id            = "${aws_vpc.environment_example_two.id}"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "subnet2" {
  cidr_block        = "${cidrsubnet(aws_vpc.environment_example_two.cidr_block, 2, 2)}"
  vpc_id            = "${aws_vpc.environment_example_two.id}"
  availability_zone = "us-west-2b"
}

resource "aws_security_group" "subnetsecurity" {
  vpc_id = "${aws_vpc.environment_example_two.id}"

  ingress {
    cidr_blocks = [
      "${aws_vpc.environment_example_two.cidr_block}",
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
}

resource "azurerm_resource_group" "azy_network" {
  location = "West US"
  name     = "devresourcegroup"
}

resource "azurerm_virtual_network" "blue_virtual_network" {
  address_space       = ["10.0.0.0/16"]
  location            = "West US"
  name                = "bluevirtualnetwork"
  resource_group_name = "${azurerm_resource_group.azy_network.name}"

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  tags {
    env = "blue-world"
  }
}
