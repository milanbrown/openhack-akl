#read more here: https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/terraform/terraform-create-k8s-cluster-with-tf-and-aks.md
# terrafrom providers https://www.terraform.io/docs/providers/
# read up on terraform modules, backends and provisioners

provider "azurerm" {
  version = "~>1.5"
}

resource "azurerm_resource_group" "rg-demo" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"

  tags {
    environment = "tf-demo"
  }
}

resource "azurerm_kubernetes_cluster" "test" {
  name                = "tfdemo-openhack"
  location            = "${azurerm_resource_group.rg-demo.location}"
  resource_group_name = "${azurerm_resource_group.rg-demo.name}"
  dns_prefix          = "${var.dns_prefix}"
  kubernetes_version  = "${var.cluster_version}"

  agent_pool_profile {
    name            = "default"
    count           = 3
    vm_size         = "${var.vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "8b030796-2329-4aed-98d9-7ff318fa1bf9"
    client_secret = "5c2ad53b-4426-4601-a05e-e3ce11706d6b"
  }

  tags {
    environment = "tf-demo"
  }
}