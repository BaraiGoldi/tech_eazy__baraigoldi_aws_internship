# tech_eazy__baraigoldi_aws_internship

## 🚀 EC2 Auto Deployment Script

This project automates:

- Launching EC2 with stage-based config
- Installing Java 19 & cloning app repo
- Running the app and testing access via port 80
- Stopping instance after a delay

## ✅ Requirements

- AWS CLI configured via `aws configure`
- IAM Role, VPC, Security Group, Subnet pre-created
- No secrets in repo; use environment variables

## 🧪 Test Instructions

1. Clone this repo.
2. Run:

```bash
cd scripts
chmod +x deploy_ec2.sh
./deploy_ec2.sh Dev
```

3. Test in browser or via Postman:

```
GET http://<EC2_PUBLIC_IP>
```

4. Wait for it to stop automatically.

## 🔒 Notes

- `.env` files contain config per stage (Dev, Prod)
- No AWS keys in repo (use ENV variables)
