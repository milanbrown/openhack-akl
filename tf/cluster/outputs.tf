output "client_key" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_key}"
}

output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate}"
}

output "cluster_username" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.username}"
}

output "cluster_password" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.password}"
}

output "kube_config" {
    value = "${azurerm_kubernetes_cluster.test.kube_config_raw}"
}

output "host" {
    value = "${azurerm_kubernetes_cluster.test.kube_config.0.host}"
}

output "lb_ip" {
  value = "${kubernetes_service.tf-minecraft.load_balancer_ingress.0.ip}"
}