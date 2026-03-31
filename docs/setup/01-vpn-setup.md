# VPN Setup - WireGuard

## Date: 15/2/2026
## Status: Working

## Topology
```
AWS Bastion (public) → VPS (10.10.0.1) ←→ Local (10.10.0.2)
```

## AWS Bastion Host

AWS is used as the public bastion host for secure entry into the hybrid environment. The bastion host provides:

- SSH access for administration
- WireGuard connectivity into the private network
- a public entry point without exposing VPS or Local directly

## Automation Approach

Instead of configuring WireGuard manually on each machine, use Ansible to:

- install the WireGuard package
- render `/etc/wireguard/wg0.conf` from a template
- enable and restart the `wg-quick@wg0` service

Use Terraform to provision the AWS bastion host:

- create the EC2 instance
- attach the bastion security group
- open SSH and WireGuard ports only to approved CIDRs

### Files used

- [Infrastructure/terraform/aws/main.tf](/home/uph3hc/project/hybrid-cloud/Infrastructure/terraform/aws/main.tf)
- [Infrastructure/terraform/aws/variables.tf](/home/uph3hc/project/hybrid-cloud/Infrastructure/terraform/aws/variables.tf)
- [Infrastructure/terraform/aws/outputs.tf](/home/uph3hc/project/hybrid-cloud/Infrastructure/terraform/aws/outputs.tf)
- [Infrastructure/ansible/playbooks/setup-bastion.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/playbooks/setup-bastion.yml)
- [Infrastructure/ansible/playbooks/setup-wireguard.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/playbooks/setup-wireguard.yml)
- [Infrastructure/ansible/inventory/hosts.ini](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/inventory/hosts.ini)
- [Infrastructure/ansible/group_vars/all.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/group_vars/all.yml)
- [Infrastructure/ansible/host_vars/bastion.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/host_vars/bastion.yml)
- [Infrastructure/ansible/host_vars/vps.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/host_vars/vps.yml)
- [Infrastructure/ansible/host_vars/local.yml](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/host_vars/local.yml)
- [Infrastructure/ansible/templates/99-bastion-hardening.conf.j2](/home/uph3hc/project/hybrid-cloud/Infrastructure/ansible/templates/99-bastion-hardening.conf.j2)
- [Infrastructure/vpn/wg0.conf.j2](/home/uph3hc/project/hybrid-cloud/Infrastructure/vpn/wg0.conf.j2)

## Automation Flow

1. Provision the AWS bastion host with Terraform.
2. Update the host inventory with the bastion public IP, plus the VPS and Local target IPs.
3. Set the SSH public key and WireGuard values in `host_vars/bastion.yml`.
4. Set the WireGuard peer keys and addresses in `host_vars/vps.yml` and `host_vars/local.yml`.
5. Run the bastion playbook from the Infrastructure directory.
6. Run the WireGuard playbook for VPS and Local.

**Terraform command:**
```bash
cd Infrastructure/terraform/aws
terraform init
terraform plan
terraform apply
```

**Run bastion command:**
```bash
cd Infrastructure
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/setup-bastion.yml
```

**Run VPS and Local command:**
```bash
cd Infrastructure
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/setup-wireguard.yml
```

## Generated Configuration

The final `/etc/wireguard/wg0.conf` is rendered automatically from `Infrastructure/vpn/wg0.conf.j2`.

### Example peer data

- AWS bastion peer: public key and allowed IPs for the public entry point
- VPS peer: public key, allowed IPs, and optional forwarding rules
- Local peer: public key, endpoint, allowed IPs, and persistent keepalive

### Required variables

- `bastion_admin_public_keys`
- `bastion_ssh_user`
- `wireguard_private_key`
- `wireguard_address`
- `wireguard_peers`
- `wireguard_interface`
- `wireguard_listen_port`

## Verification
```bash
# Check status
sudo wg show

# Test connectivity
ping -c 4 10.10.0.1  # from Local
ping -c 4 10.10.0.2  # from VPS
```

## Troubleshooting Log

### Issue 1: [If you had any issues]
**Problem:** [describe]
**Solution:** [what you did]
**Lesson:** [what you learned]

## Next Steps
- [ ] Provision AWS bastion host with Terraform
- [ ] Install K3s master on VPS
- [ ] Join Local as worker
