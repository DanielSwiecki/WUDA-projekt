variable "host" {
  description = "Local WSL endpoint used by the Terraform SSH provider."
  type        = string

  validation {
    condition     = var.host == "localhost"
    error_message = "The local WSL bootstrap supports host=localhost only."
  }
}

variable "ssh_user" {
  description = "WSL user allowed to run the restricted k3s sudo wrappers."
  type        = string
  default     = "daniel"
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "ssh_private_key_path" {
  description = "Private key used to log in to WSL."
  type        = string
  default     = "~/.ssh/id_ed25519_k3s"
}

variable "k3s_channel" {
  description = "k3s release channel, ignored when k3s_version is set."
  type        = string
  default     = "stable"
}

variable "k3s_version" {
  description = "Exact k3s version to pin, e.g. v1.31.5+k3s1. Null follows the channel."
  type        = string
  default     = null
}

variable "kubeconfig_output_path" {
  description = "Where the kubeconfig pointing at the VM is written locally."
  type        = string
  default     = "~/.kube/k3s-wuda.yaml"
}
