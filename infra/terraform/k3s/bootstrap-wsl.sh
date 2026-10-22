#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  printf '%s\n' 'Run this script as your normal WSL user, not with sudo.' >&2
  exit 1
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
sudo -v
sudo install -o root -g root -m 0755 "$script_dir/wuda-k3s-install" /usr/local/sbin/wuda-k3s-install
sudo install -o root -g root -m 0755 "$script_dir/wuda-k3s-kubeconfig" /usr/local/sbin/wuda-k3s-kubeconfig
printf '%s\n' 'daniel ALL=(root) NOPASSWD: /usr/local/sbin/wuda-k3s-install localhost *, /usr/local/sbin/wuda-k3s-kubeconfig' | sudo tee /etc/sudoers.d/wuda-k3s >/dev/null
sudo chmod 0440 /etc/sudoers.d/wuda-k3s
sudo visudo -cf /etc/sudoers.d/wuda-k3s
