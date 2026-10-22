output "app_namespace" {
  value = kubernetes_namespace_v1.this[var.app_namespace].metadata[0].name
}

output "app_url" {
  value = "http://${var.ingress_host}/polls/"
}

output "monitoring_namespace" {
  value = kubernetes_namespace_v1.this[var.monitoring_namespace].metadata[0].name
}
