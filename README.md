# Aws-DevSecOps-Pipeline
End-to-end Secure DevSecOps pipeline automating AWS infrastructure with Terraform, Docker image scanning with Trivy, and CI/CD with GitHub Actions.
# 🚧 WIP: Secure DevSecOps Pipeline (AWS & Terraform)

**Status:** Completed ✅

## 📌 Project Objective
This repository contains an end-to-end automated CI/CD pipeline built from scratch. The goal was to integrate Infrastructure as Code (IaC), container security scanning, and automated deployments to catch vulnerabilities before they reach production.

## 🏗️ Planned Architecture & Tech Stack
I built and integrated the following tools:
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
- [X] **Step 4: Security Scanning Integration**
    - Integrated **Trivy** vulnerability scanner into the GitHub Actions pipeline.
    - Configured Shift-Left security by scanning the local Docker image (`nginx:alpine`) before infrastructure deployment.
    - Enforced a pipeline break (`exit-code: 1`) if any `CRITICAL` or `HIGH` vulnerabilities are detected, acting as a strict security gate.

## 🛠 Design & Technical Decisions

During the development of this pipeline, I have been making specific architectural choices to balance security, performance, and complexity:

| Decision | Reasoning | Trade-off |
| :--- | :--- | :--- |
| **Nginx Alpine Base** | Drastically reduces the image size and the attack surface for security vulnerabilities. | Fewer debugging tools inside the container (no `curl`, `bash`, etc.). |
| **Conventional Commits** | Ensures a clean, readable, and professional git history that follows industry standards. | Requires more discipline and time when writing commit messages. |
| **Dedicated IAM Admin User** | Enforces the Principle of Least Privilege and protects the AWS Root account from accidental or malicious exposure. | Adds administrative overhead by requiring the management of multiple credentials and profiles. |
| **EC2 `t3.micro` Instance** | Stays strictly within the AWS Free Tier to keep infrastructure costs at $0 during the pipeline development. | Extremely limited compute power (2 vCPUs, 1GB RAM); might struggle with heavy container workloads. |
| **Manual Destroy Trigger** | Added `workflow_dispatch` to GitHub Actions to allow one-click infrastructure teardown from the UI. | Requires manual intervention to stop AWS charges, instead of an automatic scheduled shutdown. |
| **Trivy CI/CD Integration** | Enforces "Shift-Left" security, preventing vulnerable containers from ever reaching the AWS environment. | Increases the pipeline execution time slightly and requires defining strict vulnerability severity thresholds. |
| **Variables Modularization (`variables.tf`)** | Adheres to DRY principles, making the Terraform code reusable, cleaner, and easier to maintain across different environments. | Adds initial setup time and requires managing default values explicitly. |

> *Follow my progress! I will be updating the project with new features:
* **Continuous Deployment (CD):** Push scanned images to **AWS ECR** and automate the pull on EC2.
* **Infrastructure Auditing:** Integrate **tfsec** or **Checkov** to scan Terraform code for misconfigurations.
* **Cost Observability:** Add **Infracost** to the pipeline to monitor AWS spending per PR.
* **Notifications:** Slack/Discord alerts for pipeline success or security failures..*
