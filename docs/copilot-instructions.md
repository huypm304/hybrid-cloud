# Hybrid DevOps Platform - Cost-Optimized Infrastructure

## 1. Overview

This project is a production-inspired Hybrid DevOps Platform designed to demonstrate how to build and operate a modern cloud-native system at minimal cost.

Instead of relying entirely on expensive cloud services, this system combines:

- Cloud (AWS) for lightweight services
- VPS for control plane (always-on services)
- Local machine for heavy workloads

Goal:
> Provide CI/CD, Kubernetes orchestration, monitoring, and automation with >90% cost reduction compared to full cloud solutions.

---

## 2. Problem Statement

Early-stage developers, students, and small teams face challenges:

- Managed Kubernetes (EKS/GKE) costs ~$150+/month
- Limited access to production-like infrastructure
- Lack of hands-on experience with real DevOps workflows

This project solves:

- ❌ High cloud cost
- ❌ Lack of real system integration experience
- ❌ No end-to-end DevOps pipeline

---

## 3. Solution

A hybrid infrastructure platform:

- Uses VPS as control plane
- Uses local machine as compute node
- Connects all components via secure VPN (WireGuard)
- Fully automated via CI/CD + GitOps

---

## 4. High-Level Architecture

### Components

| Layer | Component | Role |
|------|----------|------|
| Cloud | AWS | Gateway, DNS, Terraform state |
| Control | VPS | K3s Master, Jenkins, ArgoCD |
| Compute | Local PC | K3s Worker, workloads, monitoring |

---

## 5. System Roles

### 5.1 AWS (Gateway Layer)

- Stores Terraform state (S3)
- Acts as Bastion host (EC2)
- DNS management (Route53)

Purpose:
- Secure access
- Infrastructure state management
- Public entry point

---

### 5.2 VPS (Control Plane)

Acts as "Brain" of the system.

Runs:

- K3s Master (Kubernetes control plane)
- Jenkins (CI/CD orchestrator)
- ArgoCD (GitOps deployment)
- Docker Registry
- Ingress Controller

Characteristics:

- Always online
- Stable public IP
- Lightweight workloads only

---

### 5.3 Local Machine (Worker Node)

Acts as "Muscle" of the system.

Runs:

- K3s Agent
- Application workloads
- Jenkins build agents
- Monitoring stack (Prometheus, Loki)
- Databases

Characteristics:

- High compute power
- Zero cost
- May go offline

---

## 6. Networking

All nodes are connected using WireGuard VPN.

### VPN Network:

- 10.10.0.1 → AWS
- 10.10.0.2 → VPS
- 10.10.0.3 → Local

### Properties:

- Encrypted communication
- Private IP routing
- No direct public exposure of services

---

## 7. CI/CD Pipeline Flow

### Step-by-step:

1. Developer pushes code to GitHub
2. GitHub triggers webhook
3. Jenkins (on VPS) starts pipeline
4. Pipeline stages:
   - Checkout code
   - Build Docker image
   - Security scan (Trivy)
   - Push to private registry
   - Update GitOps repo
5. ArgoCD detects changes
6. ArgoCD syncs to Kubernetes
7. K3s deploys workload on Local node
8. Application becomes available

---

## 8. Deployment Flow

### Step-by-Step Deployment Flow

1. **Developer pushes code to GitHub**  
   Source code changes are committed and pushed to the main repository.
2. **Jenkins pipeline is triggered**  
   A webhook or polling mechanism on the VPS Jenkins server detects the push and starts the CI/CD pipeline.
3. **Build & Test**  
   Jenkins checks out the code, builds the Docker image, and runs automated tests.
4. **Security Scan**  
   The built Docker image is scanned for vulnerabilities (e.g., using Trivy).
5. **Push to Private Registry**  
   If the build and scan succeed, the Docker image is pushed to the private registry hosted on the VPS.
6. **Update GitOps Repository**  
   Jenkins updates the GitOps configuration repository (e.g., modifies image tag in Kubernetes manifests).
7. **ArgoCD detects changes**  
   ArgoCD (running on the VPS) automatically detects changes in the GitOps repo.
8. **ArgoCD syncs to Kubernetes**  
   ArgoCD applies the updated manifests to the K3s cluster.
9. **K3s deploys workload**  
   The new application version is deployed to the local machine (worker node).
10. **Application is live**  
   The updated application becomes available to users.

---

## 9. Observability

### Monitoring:

- Prometheus (metrics collection)
- Grafana (dashboard)

### Logging:

- Loki (log aggregation)

### Alerting:

- Alertmanager → Telegram

---

## 10. Key Features

### 10.1 Cost Optimization

- Uses local resources instead of cloud compute
- Only pays for VPS (~$10/month)

---

### 10.2 Automation

- Fully automated CI/CD pipeline
- Zero manual deployment

---

### 10.3 Hybrid Architecture

- Combines cloud + on-premise
- Real-world production pattern

---

### 10.4 Observability

- Full metrics + logs visibility
- Faster debugging

---

## 11. Failure Scenarios

### Local Machine Down

- Workloads unavailable
- Control plane still running
- Alerts triggered

### VPS Down

- No deployment possible
- Existing workloads still running locally

### VPN Failure

- Nodes disconnected
- Monitoring detects issue

---

## 12. Limitations

- Single worker node (no HA)
- Depends on home network
- Not suitable for critical production

---

## 13. Future Improvements

- Add multiple worker nodes
- Implement auto-scaling
- Add chaos testing
- Improve security (secrets management)

---

## 14. Use Cases

- Learning DevOps & Kubernetes
- Portfolio project for job applications
- Testing CI/CD pipelines
- Hosting personal applications

---

## 15. Tech Stack

- Kubernetes: K3s
- CI/CD: Jenkins
- GitOps: ArgoCD
- Container: Docker
- IaC: Terraform, Ansible
- Monitoring: Prometheus, Grafana
- Logging: Loki
- Networking: WireGuard VPN
- Cloud: AWS (S3, EC2, Route53)

---

## 16. Key Learnings

- Hybrid infrastructure design
- VPN-based networking
- CI/CD automation
- GitOps workflow
- Cost-efficient architecture

---

## 17. Conclusion

This project demonstrates how to build a production-like DevOps platform with minimal cost while still covering real-world engineering practices such as:

- Infrastructure as Code
- Continuous Delivery
- Observability
- Secure networking

It reflects practical skills required for DevOps and System Engineering roles.

---

## 18. Project Repository Structure

This project uses a **multi-repo architecture** for better separation of concerns:

### 18.1 Application Repository (`my-app`)

Contains application source code and CI pipeline.

```
my-app/
├── src/                    # Application source code
│   ├── main/
│   └── test/
├── Dockerfile              # Container image definition
├── requirements.txt        # Python dependencies (or package.json, pom.xml)
├── tests/                  # Unit and integration tests
├── Jenkinsfile             # CI pipeline definition
├── .github/                # GitHub Actions (optional)
│   └── workflows/
├── helm/                   # Helm chart (if using Helm)
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── README.md
```

### 18.2 GitOps Repository (`gitops-infra`)

Contains Kubernetes manifests and ArgoCD configurations.

```
gitops-infra/
├── apps/                   # Application manifests
│   └── my-app/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── ingress.yaml
│       └── configmap.yaml
│
├── base/                   # Kustomize base configs
│   └── my-app/
│       ├── kustomization.yaml
│       └── resources/
│
├── environments/           # Environment-specific overlays
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   └── my-app.yaml
│   ├── staging/
│   │   └── my-app.yaml
│   └── prod/
│       └── my-app.yaml
│
├── argocd/                 # ArgoCD application definitions
│   ├── applications.yaml
│   └── projects.yaml
│
└── README.md
```

### 18.3 Infrastructure Repository (`Infrastructure`)

Contains Infrastructure as Code and automation scripts.

```
Infrastructure/
├── terraform/              # Terraform modules
│   ├── aws/                # AWS resources (S3, EC2, Route53)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vps/                # VPS provisioning
│   └── modules/            # Reusable modules
│
├── ansible/                # Configuration management
│   ├── inventory/          # Host inventory
│   ├── playbooks/          # Automation playbooks
│   │   ├── setup-k3s-master.yaml
│   │   ├── setup-k3s-agent.yaml
│   │   └── setup-monitoring.yaml
│   └── roles/              # Ansible roles
│
├── vpn/                    # WireGuard VPN configs
│   ├── aws.conf
│   ├── vps.conf
│   └── local.conf
│
├── monitoring/             # Monitoring stack configs
│   ├── prometheus/
│   │   └── prometheus.yaml
│   ├── grafana/
│   │   └── dashboards/
│   ├── loki/
│   │   └── loki-config.yaml
│   └── alertmanager/
│       └── alertmanager.yaml
│
├── scripts/                # Utility scripts
│   ├── setup-local.sh
│   ├── backup.sh
│   └── health-check.sh
│
├── docs/                   # Infrastructure documentation
│   ├── setup/
│   └── troubleshooting/
│
└── README.md
```

---

## 19. Repository Relationships

```
┌─────────────────┐     Push      ┌─────────────────┐
│   my-app        │ ─────────────▶│   Jenkins       │
│   (Application) │               │   (CI/CD)       │
└─────────────────┘               └────────┬────────┘
                                           │
                                           │ Update image tag
                                           ▼
┌─────────────────┐     Sync      ┌─────────────────┐
│   ArgoCD        │ ◀─────────────│   gitops-infra  │
│   (GitOps)      │               │   (Manifests)   │
└────────┬────────┘               └─────────────────┘
         │
         │ Deploy
         ▼
┌─────────────────┐
│   K3s Cluster   │
│   (Kubernetes)  │
└─────────────────┘
         ▲
         │ Provision
┌────────┴────────┐
│ Infrastructure  │
│   (IaC)         │
└─────────────────┘
```