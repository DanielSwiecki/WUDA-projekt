variable "kubeconfig_path" {
  description = "Path to the kubeconfig copied from the k3s node (/etc/rancher/k3s/k3s.yaml, server address replaced with the VM IP)."
  type        = string
  default     = "~/.kube/k3s-wuda.yaml"
}

variable "kube_context" {
  description = "Kubeconfig context to use; null selects the current one."
  type        = string
  default     = null
}

variable "app_namespace" {
  description = "Namespace for the application and its database."
  type        = string
  default     = "wuda"
}

variable "monitoring_namespace" {
  description = "Namespace reserved for the monitoring stack."
  type        = string
  default     = "monitoring"
}

variable "image_repository" {
  description = "Application image repository, e.g. ghcr.io/<owner>/wuda."
  type        = string
}

variable "image_tag" {
  description = "Image tag; empty uses the chart appVersion."
  type        = string
  default     = ""
}

variable "ingress_host" {
  description = "Hostname served by the ingress."
  type        = string
  default     = "wuda.local"
}

variable "replica_count" {
  type    = number
  default = 2
}
