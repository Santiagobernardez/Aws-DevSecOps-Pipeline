# Aws-DevSecOps-Pipeline
End-to-end Secure DevSecOps pipeline automating AWS infrastructure with Terraform, Docker image scanning with Trivy, and CI/CD with GitHub Actions.
# 🚧 WIP: Secure DevSecOps Pipeline (AWS & Terraform)

**Status:** Work In Progress 🛠️ (Started: Feb 20, 2026)

## 📌 Project Objective
This repository will contain an end-to-end automated CI/CD pipeline built from scratch. The goal is to integrate Infrastructure as Code (IaC), container security scanning, and automated deployments to catch vulnerabilities before they reach production.

## 🏗️ Planned Architecture & Tech Stack
I am currently building and integrating the following tools:
* **Cloud & IaC:** AWS (EC2, S3), Terraform
* **CI/CD:** GitHub Actions
* **Containers:** Docker
* **Security Scanning:** Trivy, Shell Scripting

## 🚀 Milestones & Progress
- [x] **Step 1: Application & Containerization**
    - Created a lightweight HTML5 landing page.
    - Developed a `Dockerfile` using `nginx:alpine` to minimize the attack surface.
- [x] **Step 2: Infrastructure as Code (IaC) & Security Baseline**
    - Configured AWS Root account with **MFA** and created a dedicated IAM User following the **Principle of Least Privilege**.
    - Provisioned a `t3.micro` EC2 instance using **Terraform** (Ubuntu 22.04 LTS).
    - Verified infrastructure lifecycle (Plan -> Apply -> Destroy) for cost and resource management.
- [X] **Step 3: Remote State & CI/CD Automation**
    - Migrated Terraform state to a secure remote backend (**Amazon S3**) with state locking (**DynamoDB**) to prevent concurrent modifications
    - Built an automated CI/CD pipeline using **GitHub Actions** to securely provision infrastructure on `push`, and added a `workflow_dispatch` trigger for manual teardown.
- [ ] **Step 4: Security Scanning Integration**

## 🛠 Design & Technical Decisions

During the development of this pipeline, I made specific architectural choices to balance security, performance, and complexity:

| Decision | Reasoning | Trade-off |
| :--- | :--- | :--- |
| **Nginx Alpine Base** | Drastically reduces the image size and the attack surface for security vulnerabilities. | Fewer debugging tools inside the container (no `curl`, `bash`, etc.). |
| **Conventional Commits** | Ensures a clean, readable, and professional git history that follows industry standards. | Requires more discipline and time when writing commit messages. |
| **Dedicated IAM Admin User** | Enforces the Principle of Least Privilege and protects the AWS Root account from accidental or malicious exposure. | Adds administrative overhead by requiring the management of multiple credentials and profiles. |
| **EC2 `t3.micro` Instance** | Stays strictly within the AWS Free Tier to keep infrastructure costs at $0 during the pipeline development. | Extremely limited compute power (2 vCPUs, 1GB RAM); might struggle with heavy container workloads. |
| **Manual Destroy Trigger** | Added `workflow_dispatch` to GitHub Actions to allow one-click infrastructure teardown from the UI. | Requires manual intervention to stop AWS charges, instead of an automatic scheduled shutdown. |

> *Follow my progress! This README will be updated as the pipeline is built.*
