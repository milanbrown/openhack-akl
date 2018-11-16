variable "dns_prefix" {
    default = "tf-demo"
}

variable cluster_name {
    default = "tf-demok8stest"
}

variable resource_group_name {
    default = "tf-demorg"
}

variable location {
    default = "Australia East"
}
variable cluster_version {
    default = "1.11.3"
}
variable vm_size {
    default = "Standard_DS1_v2"
}