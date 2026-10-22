provider "ssh" {}

locals {
  k3s_release = var.k3s_version != null ? var.k3s_version : var.k3s_channel
  private_key = file(pathexpand(var.ssh_private_key_path))
}

resource "ssh_resource" "install" {
  host        = var.host
  port        = var.ssh_port
  user        = var.ssh_user
  private_key = local.private_key
  timeout     = "10m"

  triggers = {
    host    = var.host
    release = local.k3s_release
  }

  commands = ["sudo /usr/local/sbin/wuda-k3s-install '${var.host}' '${local.k3s_release}'"]
}

resource "ssh_resource" "kubeconfig" {
  host        = var.host
  port        = var.ssh_port
  user        = var.ssh_user
  private_key = local.private_key
  timeout     = "2m"

  triggers = {
    install = ssh_resource.install.id
  }

  commands = ["sudo /usr/local/sbin/wuda-k3s-kubeconfig"]
}

resource "local_sensitive_file" "kubeconfig" {
  filename        = pathexpand(var.kubeconfig_output_path)
  file_permission = "0600"
  content         = replace(ssh_resource.kubeconfig.result, "https://127.0.0.1:6443", "https://${var.host}:6443")
}
