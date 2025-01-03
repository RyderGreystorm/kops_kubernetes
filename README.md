
# Fullstack DevOps Project with Kubernetes and Kops

<div align="right">
  <img src="/assets/kops.gif" alt="Coding Animation"/>
</div>

## Table of Contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup Guide](#setup-guide)
  - [Kops Cluster Setup](#kops-cluster-setup)
  - [Deploying to Kubernetes](#deploying-to-kubernetes)
- [Project Structure](#project-structure)
- [Manifest Files](#manifest-files)
- [Terraform Infrastructure](#terraform-infrastructure)
- [Key Pair Configuration](#key-pair-configuration)
- [Ingress Configuration](#ingress-configuration)
- [Contact and Documentation](#contact-and-documentation)

## Project Overview
This project deploys a fullstack application in a Kubernetes cluster, managed by Kops (Kubernetes Operations). The deployment includes backend services, frontend services, a database, and caching layers, all orchestrated via Kubernetes manifests and Terraform Infrastructure as Code (IaC).

## Architecture
- **Frontend**: Tomcat-based application deployment.
- **Backend**: Services including database, message queue, and caching layers.
- **Infrastructure**: Provisioned kops admin server using Terraform.
- **Kubernetes**: Managed with Kops for creating and maintaining the cluster.

## Prerequisites
- AWS CLI installed and configured.
- Kops installed (`brew install kops` or [install guide](https://kops.sigs.k8s.io/getting_started/install/)).
- Terraform installed (`brew install terraform`).
- Domain configured in Route 53 for Kops.
- SSH key pair generated.

## Setup Guide

### Kops Cluster Setup
1. **Create S3 Bucket for State Storage**:
   ```bash
   aws s3api create-bucket --bucket <bucket_name> --region <region_name>
   ```
2. **Create cluster**:
   ```bash
   kops create cluster --name=profile.devopsfetish.xyz \
   --state=s3://biekro-kops \
   --zones=us-east-1a,us-east-1b,us-east-1c \
   --node-count=2 \
   --node-size=t3.medium \
   --control-plane-size=t3.medium \
   --dns-zone=profile.devopsfetish.xyz \
   --node-volume-size=25 \
   --control-plane-volume-size=25 \
   --ssh-public-key=~/.ssh/kops.publ
   ```


### Deploying to Kubernetes
1. **Apply Backend Manifests**:
   ```bash
   kubectl apply -f backend_manifests/
   ```
2. **Apply Frontend Manifests**:
   ```bash
   kubectl apply -f frontend/
   ```
3. **Apply Ingress Configuration**:
   ```bash
   kubectl apply -f ingress.yml
   ```

## Project Structure
```
k8s_kops_fullstack_devops/
|-- README.md
|-- assets
|   `-- kops.gif
|-- backend_manifests
|   |-- db_deployment.yml
|   |-- db_pvc.yml
|   |-- db_service.yml
|   |-- memcache_deploy.yml
|   |-- memcache_svc.yml
|   |-- rmq_deploy.yml
|   |-- rmq_svc.yml
|   `-- secret.yml
|-- frontend
|   |-- tomcat_deploy.yml
|   `-- tomcat_svc.yml
|-- ingress.yml
|-- key_pair
|   |-- mykey
|   |-- mykey.pem
|   `-- mykey.pub
|-- kops_setup.sh
|-- terraform.tfstate
`-- terraform_iac
    |-- backend.tf
    |-- main.tf
    |-- modules
    |   |-- ec2.tf
    |   |-- route53_hostedzone.tf
    |   |-- variables.tf
    |   `-- vpc.tf
    |-- terraform.tfvars
    `-- variables.tf
```

## Manifest Files
- **Database**: db_deployment.yml, db_service.yml, db_pvc.yml
- **Cache**: memcache_deploy.yml, memcache_svc.yml
- **Queue**: rmq_deploy.yml, rmq_svc.yml
- **Secrets**: secret.yml

## Terraform Infrastructure
- **VPC and Networking**: vpc.tf
- **Compute Instances**: ec2.tf
- **DNS and Routing**: route53_hostedzone.tf

## Key Pair Configuration
- Store the SSH key pair in the key_pair directory.
- Use this key for SSH access to provisioned instances.

## Ingress Configuration
- ingress.yml configures external access to frontend and backend services.

## Contact and Documentation
- **Medium Article (Full Documentation)**: [Read the full project documentation on Medium](https://medium.com/@biekrogodbless/kubernetes-with-kops-kubernetes-operation-set-up-a37b01931ec9)
- **LinkedIn**: [Godbless Biekro](https://www.linkedin.com/in/godbless-biekro-2289261ba/)
- **Medium**: [Medium Profile](https://medium.com/@biekrogodbless)
- **Email**: biekrogodbless@gmail.com

---
Thank you for exploring this project! Reach out for any questions or collaboration.

