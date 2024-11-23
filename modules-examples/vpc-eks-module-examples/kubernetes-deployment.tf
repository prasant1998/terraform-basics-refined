# Create a Deployment
resource "kubernetes_deployment" "test" {
  metadata {
    name = "test-deployment"
    labels = {
      app = "test"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "test"
      }
    }

    template {
      metadata {
        labels = {
          app = "test"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "test"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}

# Create a Service
resource "kubernetes_service" "test" {
  metadata {
    name = "test-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.test.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}