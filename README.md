# Serverless Resume CI/CD Pipeline build

[![AWS S3](https://img.shields.io/badge/AWS-S3-orange?logo=amazons3&logoColor=white)](https://aws.amazon.com/s3/)
[![AWS CloudFront](https://img.shields.io/badge/AWS-CloudFront-blue?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/cloudfront/)
[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![Infrastructure as Code](https://img.shields.io/badge/IaC-Automation-green)](https://aws.amazon.com/)

A production site which is fully automated using Infrastructure as Code (IaC) and CI/CD deployment pipeline for hosting a high-availability, low-latency cloud resume on **AWS S3** and **Amazon CloudFront** and **Route S5** . Built using **GitHub Actions pipeline**, this repository demonstrates automated deployment workflows, cache invalidation, static asset hosting, and cloud security best practices.

---


## 🏗️ Architecture Overview (PLAN)
![Architecture Diagram](asset/architecture.png)

---

### Technical Features

* **Stateless & Highly Available Architecture:** Serves static web assets via Amazon S3 backed by CloudFront edge locations worldwide and DNS.
* **Automated Deployment Pipeline:** GitHub Actions automatically triggers on pushes to the `any` branch, syncing local changes to the AWS S3 bucket.
* **Global Low-Latency CDN:** Integrated Amazon CloudFront CDN with automated edge cache invalidation (`/*`) ensuring updates propagate globally in real time.
* **Secure Credential Handling:** Enforces principle of least-privilege using AWS IAM programmatic access keys managed securely via GitHub Encrypted Secrets.


## 📁 Repo Structure

```text
serverless-resume-cicd/
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions CI/CD workflow configuration
├── .gitignore                # System and personal file exclusions
├── index.html                # your resume code here
└── README.md                 # Project documentation

```

---

## STEP BY STEP PROCESS. 

### Prerequisites

1. An active **AWS Account** with access to S3 and CloudFront.
2. An **AWS IAM User** with s3 and CDN previledges.

### Setup Instructions

1. **Fork & Clone the Repository:**
```bash
git clone git@github.com:YOUR-USERNAME/serverless-resume-cicd.git
cd serverless-resume-cicd

```


2. **Add Personal Profile Image:**
Add your professional profile headshot to the root directory and name it `profile.jpg` (Note: `profile.jpg` is ignored by `.gitignore` to prevent tracking personal images) you have to remove the profile ignore section and push to a private.

3. **Configure GitHub Repository Secrets:**
Navigate to **Settings > Secrets and variables > Actions** in your GitHub repository and add:
* `AWS_ACCESS_KEY_ID`: Your IAM user access key
* `AWS_SECRET_ACCESS_KEY`: Your IAM user secret access key
* `CLOUDFRONT_DIST_ID`: Your Amazon CloudFront Distribution ID
* `BUCKET_ADDRESS`: Your bucket Address


4. **Update `deploy.yml` Configuration:**
Modify `.github/workflows/deploy.yml` with your S3 bucket name and preferred AWS region:
```yaml
- name: Sync Files to S3 Bucket
  run: |
    aws s3 sync . s3://YOUR-S3-BUCKET-NAME --delete --exclude ".git/*" --exclude ".github/*"

```


5. **Deploy Changes:**
Commit and push your changes to trigger the automated CI/CD pipeline:
```bash
git add .
git commit -m "feat: setup automated deployment pipeline"
git push -u origin main

```



---

## 👤 Author

**Stephen Oni**

*Cloud Infrastructure & DevOps Engineer*

* **Portfolio:** [stephenoni.mytunnel.org](https://www.google.com/search?q=http://stephenoni.mytunnel.org)
* **LinkedIn:** [stephen-omololu](https://www.google.com/search?q=http://linkedin.com/in/stephen-omololu)

---

## 📄 License

This project is open-source and available under the [MIT License](https://www.google.com/search?q=LICENSE).