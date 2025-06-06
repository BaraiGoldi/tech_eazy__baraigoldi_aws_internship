#!/bin/bash
yum update -y
amazon-linux-extras enable corretto
yum install -y java-19-amazon-corretto
yum install -y git

cd /home/ec2-user
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops
chmod +x start.sh
./start.sh
