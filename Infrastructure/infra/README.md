# Infra

This folder contains provisioning and operational infrastructure.

## Secrets

Store private values such as WireGuard private keys, SSH keys, passwords, and tokens in Ansible Vault, not in plain YAML files.
Use per-host vault files under `Infrastructure/infra/ansible/host_vars/<host>/vault.yml` and matching password files at `Infrastructure/.vault_pass.<host>.txt` on the local machine that runs Ansible.
The current vault identities are `bastion`, `vps`, and `worker`.

## Contents

- `terraform/`: cloud resources and supporting modules
- `ansible/`: configuration management and host setup
- `vpn/`: WireGuard templates and config snippets
- `monitoring/`: Prometheus, Grafana, Loki, and Alertmanager assets
- `scripts/`: helper scripts
- `docs/`: setup and troubleshooting notes

## Runtime Roles

- VPS: K3s control plane/master, Jenkins, ArgoCD, registry
- Worker machine (formerly local): K3s worker/slave and workload host
