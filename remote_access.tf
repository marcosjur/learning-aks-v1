
module "public_ip_vm" {
  source              = "./modules/public_ip"
  name                = "pubip-zbs-vm-dev"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
}

resource "azurerm_network_security_group" "sg1" {
  name                = "acceptanceTestSecurityGroup1"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  security_rule {
    name                       = "my_ip"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "177.98.153.217"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface" "nic" {
  name                = "nic-zbs-mng-dev"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.subnet_internal.Subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = module.public_ip_vm.id
  }
}

resource "azurerm_network_interface_security_group_association" "sgassociate" {
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.sg1.id
}

resource "azurerm_linux_virtual_machine" "manager" {
  name                = "vm-zbs-mng-dev"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser" # don't change
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDARnag7ijlDxioMKgfd4WylacDvXaJPsPXp60MSqbcf27tVlYRb65Fg3huA9rZOFtXPDAwbdQqYSNppdbrLx9+RMgwzR21AnIh33HjCMHj5R83U/MfneZkGIazYznva8SzbiCZelhgeD/PwNWgd+oSbzRRVjh9lacIX5OSH0eHK1KGieUI/AbSTPglcBrTlnn6acfRQmi/+P1B2rVuIkfdzu0nku1tEcwzo3A8z3QCLI5Uc/8s75058VhsdUw0uF9yUZjaipU2aLzHg1KUU+nC84kX+77Ektb5sLy7e6bqobgGf51WFHqUSJDjyCmkBOKdCrxAGwW2XRicOFFymJ5Eoh+vgDDmQF1sPcatXBwROfhbfPqnjodF04YVdVsPzEdw3nWa4tj69+dzIPMA+hFHtqFQiL6hU4QvSa8T2EyTF09+jFaj5xRgcA+rlV7k74OTFAHccFU3I7gcEd+z1G9WqVwp05Pzstl6fEo8m6e0pk8YqTfDCDG+ZgXEgtBKlSc= marcosjunior@jaeger"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}