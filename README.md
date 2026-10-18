# WUDA project

Django "polls" app deployed to a k3s cluster, provisioned with Terraform and packaged with Docker and Helm.

## Repository layout

| Path               | Purpose                                  |
| ------------------ | ---------------------------------------- |
| `app/`             | Django application                       |
| `docker/`          | Dockerfile and local compose environment |
| `infra/terraform/` | Cluster platform provisioning            |
| `deploy/helm/`     | Helm chart for the application           |
| `docs/`            | Diagrams and extra documentation         |

Work in progress: see the commit history for the current stage.
