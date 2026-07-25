output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "dashboard_service_ip" {
  value = kubernetes_service.dashboard_service.status[0].load_balancer[0].ingress[0].ip
}
