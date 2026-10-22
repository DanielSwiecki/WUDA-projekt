locals {
  namespaces = {
    (var.app_namespace)        = "app"
    (var.monitoring_namespace) = "monitoring"
  }
}

resource "kubernetes_namespace_v1" "this" {
  for_each = local.namespaces

  metadata {
    name = each.key

    labels = {
      "app.kubernetes.io/part-of"          = "wuda"
      "app.kubernetes.io/managed-by"       = "terraform"
      "wuda/role"                          = each.value
      "pod-security.kubernetes.io/enforce" = "baseline"
      "pod-security.kubernetes.io/warn"    = "restricted"
    }
  }
}

resource "helm_release" "wuda" {
  name      = "wuda"
  namespace = kubernetes_namespace_v1.this[var.app_namespace].metadata[0].name
  chart     = "${path.module}/../../../deploy/helm/wuda"

  wait    = true
  timeout = 600

  set {
    name  = "image.repository"
    value = var.image_repository
  }

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set {
    name  = "ingress.host"
    value = var.ingress_host
  }

  set {
    name  = "replicaCount"
    value = var.replica_count
  }
}
