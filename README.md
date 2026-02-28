# 🛡️ AWS DevSecOps Pipeline: End-to-End Secure Infrastructure

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4.svg?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E.svg?logo=amazon-aws)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF.svg?logo=github-actions)](https://github.com/features/actions)
[![Trivy](https://img.shields.io/badge/Security-Trivy-blue)](https://aquasecurity.github.io/trivy/)
[![tfsec](https://img.shields.io/badge/Security-tfsec-orange)](https://aquasecurity.github.io/tfsec/)

**Status:** Completed ✅

## 📌 Project Overview
This project demonstrates a fully automated, secure, and cost-efficient CI/CD pipeline. It provisions cloud infrastructure on AWS using Terraform and deploys a containerized web application via GitHub Actions. The pipeline integrates **Shift-Left security** (Trivy & tfsec) and **Cost Governance** (AWS Budgets) to ensure a production-ready environment.

## 🏗️ Architecture & Tech Stack
* **Cloud & IaC:** AWS (EC2, ECR, S3, DynamoDB, IAM, Budgets), Terraform
* **CI/CD:** GitHub Actions (Automated Pipelines, Workflow Dispatch)
* **Containerization:** Docker (Nginx Alpine)
* **Security & Auditing:** Trivy (Images), tfsec (IaC), AWS ECR Scanning

## 🏗️ Cloud Architecture & CI/CD Pipeline
```mermeid
flowchart TB
    subgraph CI_CD [&quot;🚀 GitHub Actions (CI/CD Pipeline)&quot;]
        direction TB
        Commit[&quot;Developer Push&quot;] --&gt; Checkout[&quot;Checkout Code&quot;]
        Checkout --&gt; TF_Sec[&quot;🔒 tfsec (IaC Security Scan)&quot;]
        Checkout --&gt; DockerBuild[&quot;🐳 Build Docker Image&quot;]
        DockerBuild --&gt; Trivy[&quot;🛡️ Trivy (Vulnerability Scan)&quot;]
        
        TF_Sec --&gt; TF_Apply[&quot;🏗️ Terraform Apply&quot;]
        Trivy --&gt;|If 0 CRITICAL| PushECR[&quot;☁️ Push to AWS ECR&quot;]
    end

    subgraph AWS [&quot;☁️ AWS Cloud Infrastructure&quot;]
        direction TB
        
        subgraph TF_Backend [&quot;Terraform Remote Backend&quot;]
            S3[(&quot;🪣 Amazon S3\n(State File)&quot;)]
            DynamoDB[(&quot;⚡ DynamoDB\n(State Locking)&quot;)]
        end

        ECR[&quot;📦 Amazon ECR\n(Private Registry)&quot;]
        IAM[&quot;🔑 IAM Role &amp;\nInstance Profile&quot;]
        Budgets[&quot;💰 AWS Budgets\n(Cost Governance)&quot;]
        
        subgraph VPC [&quot;VPC &amp; Networking&quot;]
            SG[&quot;🛡️ Security Groups\n(Least Privilege)&quot;] --&gt; EC2[&quot;💻 EC2 Instance\n(t3.micro)&quot;]
        end
    end

    %% Connections
    TF_Apply -.-&gt;|Reads/Writes State| S3
    TF_Apply -.-&gt;|Acquires Lock| DynamoDB
    
    TF_Apply ==&gt;|Provisions| VPC
    TF_Apply ==&gt;|Configures| IAM
    TF_Apply ==&gt;|Sets Alerts| Budgets
    TF_Apply ==&gt;|Creates| ECR

    PushECR ==&gt;|Stores Image| ECR
    
    IAM -.-&gt;|Grants Secure Pull Access| EC2
    EC2 ==&gt;|Pulls Container Image| ECR

```
## 🚀 Key Milestones & Security Gates

- [x] **Infrastructure as Code (IaC):** Provisioned a `t3.micro` EC2 instance using Amazon Linux 2023.
- [x] **Remote State Management:** Configured S3 for state storage and DynamoDB for state locking to prevent concurrent modifications.
- [x] **IaC Security Auditing (tfsec):** Integrated **tfsec** to scan Terraform HCL files for security misconfigurations before any resource is created.
- [x] **Container Security (Trivy):** Automated Docker image scanning in the pipeline, enforcing a fail-fast mechanism if `CRITICAL` or `HIGH` vulnerabilities are found.
- [x] **Continuous Deployment (CD):** Automatic Build & Push to a private **AWS ECR** with `scan_on_push` enabled.
- [x] **Cost Governance:** Provisioned **AWS Budgets** via Terraform to monitor spending and trigger email alerts at 80% of the Free Tier limit.
- [x] **Secure Access:** Utilized **IAM Roles & Instance Profiles** for EC2-to-ECR communication, following the Principle of Least Privilege.

---

## 🛠️ Design & Technical Decisions (Trade-offs)

| Decision | Reasoning | Trade-off |
| :--- | :--- | :--- |
| **tfsec Integration** | Performs Static Analysis Security Testing (SAST) on IaC to catch misconfigurations (e.g., open ports) before deployment. | May require `tfsec:ignore` for specific intentional low-risk testing configurations. |
| **AWS Budgets via HCL** | Ensures cost transparency. Provides immediate email alerts if the infrastructure scales unexpectedly. | Requires maintaining notification emails within the infrastructure code. |
| **Nginx Alpine Base** | Drastically reduces the image size and the attack surface for vulnerabilities. | Fewer debugging tools inside the container (no `curl` or `bash`). |
| **IAM Role for EC2** | Eliminates the need for static `AWS_ACCESS_KEY` on the server, using temporary secure tokens instead. | Slightly increases Terraform complexity compared to using static credentials. |

---

## ⚙️ How to Reproduce (Usage)

1. **Fork** this repository.
2. Set up an AWS IAM User and an S3/DynamoDB backend for Terraform state.
3. Configure GitHub Secrets: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
4. Trigger the workflow via the **Actions** tab.
5. **Cleanup:** Use the `destroy` input in the workflow dispatch to tear down all resources and avoid costs.

---

## 📸 Visual Evidence

**1. CI/CD Pipeline (Scanning & Provisioning):**
![Pipeline Workflow](./images_of_the_project/Workflow.JPG)

**2. Shift-Left Security (Clean ECR Scan after patching):**
![ECR Security Scan](./images_of_the_project/ECR.JPG)

**3. Infrastructure Proof (EC2 Running):**  
![EC2 Instance Running](./images_of_the_project/EC2.JPG)

**4. Final Deployed Application:**
![Live Web Application](./images_of_the_project/Web.JPG)

---

## 👨‍💻 About the Author
**Santiago Bernardez**
* Student at **UNLaM** (Universidad Nacional de La Matanza)
* Junior Cloud Engineer | DevSecOps & Terraform
* 🔗 [LinkedIn](https://www.linkedin.com/in/santiago-bernardez-dev/)
* 📧 [Email](mailto:santiabernardez0@gmail.com)
