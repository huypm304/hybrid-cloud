# Tóm tắt ngày 2026-03-31

## 1. Tôi đã làm được gì

- Gộp GitOps Repository và Infrastructure Repository thành một repo nền tảng duy nhất.
- Tách rõ cấu trúc bên trong repo thành 2 nhánh:
  - `gitops/`: manifests Kubernetes, Kustomize, ArgoCD
  - `infra/`: Terraform, Ansible, VPN, monitoring, scripts, docs
- Thêm README cho repo gốc và từng nhánh để người mới dễ hiểu cấu trúc.
- Chuyển secrets sang Ansible Vault thay vì để plaintext trong YAML.
- Tách vault riêng theo từng host:
  - `bastion`
  - `vps`
  - `worker`
- Tách vault password theo từng host/môi trường làm việc, chỉ dùng ở máy local chạy Ansible.
- Đổi tên host `local` thành `worker` để đỡ lẫn với khái niệm local machine.
- Cập nhật tài liệu để phản ánh mô hình runtime:
  - VPS = control plane / master
  - Worker machine = worker / slave

## 2. Những điều cần tìm hiểu thêm

- Ansible Vault:
  - cách tạo, rekey, decrypt, view
  - cách tổ chức vault theo host và theo môi trường
- Ansible inventory:
  - cách đặt host alias
  - cách dùng `host_vars` và `group_vars`
- K3s:
  - control plane trên VPS
  - worker node trên máy local
  - cách join node vào cluster
- GitOps với ArgoCD:
  - cấu trúc app, base, overlays
  - cách ArgoCD sync từ repo
- Terraform + Ansible:
  - Terraform cho hạ tầng
  - Ansible cho cấu hình hệ điều hành và dịch vụ
- WireGuard:
  - thiết kế mạng riêng giữa VPS và local
  - private key, public key, peer, allowed IPs

## 3. Những thứ cần thiết để làm dự án này

### Hạ tầng
- 1 VPS public IP ổn định để làm control plane/master
- 1 máy local hoặc worker để chạy workload
- Kết nối mạng đủ ổn định giữa hai node
- WireGuard VPN để nối các node

### Công cụ
- Git
- Ansible
- Ansible Vault
- Terraform
- K3s
- ArgoCD
- Jenkins
- Docker
- kubectl

### Kiến thức nền
- Linux cơ bản
- YAML
- Kubernetes cơ bản
- CI/CD
- GitOps
- Networking cơ bản
- Quản lý secrets

## 4. Trạng thái hiện tại

- Cấu trúc repo đã rõ hơn và đỡ rối hơn trước.
- Secrets không còn nằm trực tiếp trong file thường.
- Host inventory đã dùng `worker` thay cho `local`.
- Tài liệu đã mô tả rõ vai trò của VPS và worker.

## 5. Việc nên làm tiếp

- Chuẩn hóa lại README setup để thành một luồng hoàn chỉnh từ đầu đến cuối.
- Viết checklist triển khai thực tế cho VPS và worker.
- Kiểm tra lại playbook Ansible sau khi đổi tên host.
- Hoàn thiện cách đặt secrets theo host và theo môi trường nếu sau này có dev/staging/prod.
