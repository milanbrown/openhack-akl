provider "kubernetes" {
  host                   = "${azurerm_kubernetes_cluster.test.kube_config.0.host}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.test.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.test.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.test.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_service" "tf-minecraft" {
  metadata {
    name = "tf-minecraftsvc"
  }

  spec {
    selector {
      app = "${kubernetes_pod.minecraftpod.metadata.0.labels.app}"
    }

    session_affinity = "ClientIP"

    port {
      name        = "game"
      protocol    = "TCP"
      port        = 25565
      target_port = 25565
    }

    port {
      name        = "mgmt"
      protocol    = "TCP"
      port        = 25575
      target_port = 25575
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "minecraftpod" {
  metadata {
    name = "tf-minecraftpod"

    labels {
      app = "minecraft"
    }
  }

  spec {
    container {
      image = "openhack/minecraft-server:2.0"
      name  = "minecraft"

      env {
        name  = "EULA"
        value = "TRUE"
      }
    }
  }
}
