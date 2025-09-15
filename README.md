# 🌍 Skybound Travel Auto Scaling Infrastructure with Terraform  

This project provisions a **highly available, fault-tolerant AWS infrastructure** using **Terraform**. It was designed for **Skybound Travel LLC** to handle holiday traffic surges by automatically scaling EC2 instances across multiple subnets in the default VPC.  

## 🚀 Features  

- **Auto Scaling Group (ASG)** across **two subnets** (`172.31.16.0/20` and `172.31.64.0/20`) for high availability  
- **Security Group** that allows inbound HTTP (port 80) from the internet  
- **Apache Web Server** automatically installed via `user_data.sh`  
- **ASG capacity:** minimum 2 instances, maximum 5 instances  
- **Self-healing infrastructure:** terminate one instance, another spins up automatically  
- **S3 bucket** for storing Terraform remote backend (versioned, encrypted, rollback-ready)  
- **Outputs:** public IPs and subnet IDs of ASG instances, plus S3 bucket name  

---

## 🏗️ Project Structure  

```
aws-asg-alb-ec2-with-terraform/
├── main.tf          # Core infrastructure: VPC, SG, Launch Template, ASG, S3 backend
├── variables.tf     # Input variables for flexibility
├── providers.tf     # Providers and remote backend config
├── outputs.tf       # Outputs (IPs, subnets, bucket name)
├── user_data.sh     # Script to install and run Apache
└── README.md        # Project documentation
```

---

## ⚙️ Prerequisites  

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5  
- AWS CLI configured with credentials (`aws configure`)  
- An AWS account with a default VPC (CIDR `172.31.0.0/16`)  

---

## 📦 Usage  

### 1. Clone the repository  
```bash
git clone https://github.com/KHard2Bme/aws-asg-alb-ec2-with-terraform.git
cd aws-asg-alb-ec2-with-terraform
```

### 2. Initialize Terraform  
Update `providers.tf` with your **S3 backend details** or pass them in via CLI:  
```bash
terraform init   -backend-config="bucket=skybound-tfstate-053422dc"   -backend-config="key=terraform/state.tfstate"   -backend-config="region=us-east-1"   -backend-config="encrypt=true"
```

### 3. Plan the deployment  
```bash
terraform plan -var="s3_bucket_name=skybound-tfstate-053422dc"
```

### 4. Apply the configuration  
```bash
terraform apply -auto-approve -var="s3_bucket_name=skybound-tfstate-053422dc"
```

---

## 🔍 Verification  

- Run `terraform output` to view:  
  - Public IPs of EC2 instances  
  - Subnets where they’re running  
  - S3 bucket name for remote backend  

- Open one of the **public IPs in your browser**:  
  ```
  http://<PUBLIC-IP>
  ```
  You should see:  
  ```
  Welcome to Skybound Travel! Served from <hostname>
  ```

- Manually terminate one EC2 instance from the AWS Console — the Auto Scaling Group will automatically launch a new one to maintain the minimum capacity of 2.  

---

## 🛠️ Cleanup  

To avoid ongoing AWS charges, destroy the infrastructure when done:  
```bash
terraform destroy -auto-approve -var="s3_bucket_name=skybound-tfstate-053422dc"
```

---

## 📌 Next Steps  

- Add an **Application Load Balancer (ALB)** for a single DNS endpoint  

---

## 📖 License  

This project is licensed under the MIT License.  

