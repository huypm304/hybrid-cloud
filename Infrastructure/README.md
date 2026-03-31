# Infrastructure

This repository combines GitOps and platform infrastructure in one place.

## Layout

- `gitops/`: Kubernetes manifests, Kustomize bases, environment overlays, and ArgoCD definitions
- `infra/`: Terraform, Ansible, VPN configs, monitoring, scripts, and operational docs

## Flow

- Application changes are built in the application repository
- Jenkins updates manifests in `Infrastructure/gitops`
- ArgoCD syncs the updated manifests to the cluster
- `Infrastructure/infra` is used to provision and operate the supporting environment

## Notes

Keep GitOps content and provisioning content separated by folder, even though they live in the same repository.
