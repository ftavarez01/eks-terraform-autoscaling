# **THIS PROJECT IS UNDER CONSTRUCTION YET.**
# **Project: eks-terraform-autoscaling-group**
  
Project Description:

This project deploys a scalable and highly available Kubernetes cluster on Amazon Web Services (AWS) using Terraform. It leverages Amazon EKS as the control plane and configures two distinct node groups: one for standard, on-demand workloads and another using cost-effective Spot Instances. The infrastructure is designed to automatically adjust its size based on workload demand using the Kubernetes Cluster Autoscaler, ensuring optimal performance and cost efficiency.

Key Features

*   Infrastructure as Code (IaC): Manages all AWS resources using Terraform.

*   Scalability: Implements the Cluster Autoscaler for dynamic scaling.

*  Cost Optimization: Utilizes AWS Spot Instances to reduce compute costs.

* High Availability: Deploys resources across multiple availability zones.

## Prerequisites

* Terraform: The tool for deploying the infrastructure.

* AWS CLI: The AWS command-line interface to interact with your account.

* kubectl: The tool to interact with the Kubernetes cluster once it's deployed.

## Project Structure

```bash
.
├── 📂 .github/
│   └── 📂 workflows/
│       └── ⚙️ main.yml
│
├── ☸️ kubernetes/
│   ├── 📄 deployment-cluster-autoscaler.yaml
│   ├── 📄 rbac-cluster-autoscaler.yaml
│   ├── 📄 hpa-stress-test.yaml
│   ├── 📄 deployment-main-app.yaml
│   ├── 📄 service-account-cluster-autoscaler.yaml
│   └── ... (anothers kubernetes manifest file)
│
├── 🌍 terraform/
│   ├── ☸️ EKS
│   │   ├── 📄 aws-eks-cluster.tf
│   │   ├── 📄 aws-kubeconfig.tf
│   │   ├── 📄 aws-nodes.tf
│   │   └── 📄 aws-addons.tf
│   │
│   ├── 🔐 IAM
│   │   ├── 📄 aws-iam-autoscaler.tf
│   │   ├── 📄 aws-iam-load_balancer_controller.tf
│   │   ├── 📄 aws-iam-oidc.tf
│   │   └── 📄 iam-policy.json  (opcional, no es .tf)
│   │
│   ├── 🌐 Networking
│   │   ├── 📄 aws-vpc.tf
│   │   ├── 📄 aws-subnets.tf
│   │   ├── 📄 aws-igw.tf
│   │   ├── 📄 aws-netgw.tf
│   │   ├── 📄 aws-routes.tf
│   │   └── 📄 aws-segurity-groups.tf
│   │
│   ├── ⚙️ Config
│   │   ├── 📄 aws-provider.tf
│   │   └── 📄 aws-variables.tf
│   │
│   └── ... (anothers .tf)
