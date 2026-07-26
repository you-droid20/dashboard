resource "kubernetes_deployment" "dashboard" {
  metadata {
    name = "dashboard-deployment"
    labels = {
      app = "dashboard"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "dashboard"
      }
    }

    template {
      metadata {
        labels = {
          app = "dashboard"
        }
      }

      spec {
        container {
          name  = "dashboard"
          image = var.image

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "dashboard_service" {
  metadata {
    name = "dashboard-service"
  }

  spec {
    selector = {
      app = "dashboard"
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
