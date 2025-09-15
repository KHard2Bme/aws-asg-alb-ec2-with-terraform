# 🚀 Skybound Travel Agency AWS Auto Scaling + ALB with Terraform

This project provisions highly available, fault-tolerant infrastructure on AWS for **Skybound Travel Agency LLC** using **Terraform**.  
It leverages an **Auto Scaling Group (ASG)** of EC2 instances running Apache, fronted by an **Application Load Balancer (ALB)** for traffic distribution.  
The setup ensures scalability during peak holiday traffic and cost efficiency during low usage.  

---

## 📐 Architecture Overview
- **Default VPC** with two existing subnets:
  - `172.31.16.0/20`
  - `172.31.64.0/20`
- **Security Groups**:
  - ALB SG → allows inbound HTTP (80) from the internet.
  - EC2 SG → allows HTTP traffic **only from ALB**, plus restricted SSH.
- **Application Load Balancer (ALB)**:
  - Distributes inbound traffic across instances in two subnets.
  - Provides a single DNS entry for external access.
- **Auto Scaling Group (ASG)**:
  - Min 2, Max 5 EC2 instances.
  - Launch Template bootstraps Apache using `user_data.sh`.
  - Automatically replaces unhealthy instances.
- **S3 Remote Backend**:
  - Stores Terraform state with versioning and encryption.

---

## 🛠️ Files in This Project
aws-asg-alb-ec2-with-terraform/
- `main.tf` → Defines VPC resources, Security Groups, ALB, ASG, and S3 backend bucket.
- `variables.tf` → Input variables (project name, instance type, ASG size, allowed SSH IP, etc.).
- `providers.tf` → AWS provider and backend configuration.
- `outputs.tf` → Exports ALB DNS name and other useful outputs.
- `user_data.sh` → Bootstraps Apache webserver on EC2 instances.

---

## ⚙️ Deployment Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/KHard2Bme/aws-asg-alb-ec2-with-terraform.git

   cd aws-asg-alb-ec2-with-terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Validate configuration**:
   ```bash
   terraform validate
   ```

4. **Preview resources**:
   ```bash
   terraform plan
   ```

5. **Apply infrastructure**:
   ```bash
   terraform apply -auto-approve
   ```

---

## 🌐 Accessing the Application
After apply completes, Terraform will output the **ALB DNS name**:  

```bash
Outputs:

alb_dns_name = "skybound-travel-alb-123456789.us-east-1.elb.amazonaws.com"
```

Open this DNS in your browser:  

```
http://skybound-travel-alb-123456789.us-east-1.elb.amazonaws.com
```

You should see the Apache welcome page or the custom message from your `user_data.sh` script.

---

## 🧹 Cleanup
When finished, destroy all provisioned AWS resources to avoid charges:  
```bash
terraform destroy -auto-approve
```

---

## ✅ Key Features
- 🌍 Highly available across two subnets.  
- ⚖️ Auto Scaling with min=2, max=5 instances.  
- 🔒 Security: EC2 accepts traffic **only from ALB**.  
- 🔄 ALB distributes load automatically.  
- 📦 S3 remote backend with versioning and encryption.  

---

## 📌 Notes
- Ensure your AWS credentials are configured (`aws configure`) before running Terraform.  
- Update `variables.tf` with your allowed SSH IP address for secure access.  
- Default VPC must exist in your target region (project assumes AWS provides it).  
