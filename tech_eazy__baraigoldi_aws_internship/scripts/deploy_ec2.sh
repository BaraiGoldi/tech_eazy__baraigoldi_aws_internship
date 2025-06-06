#!/bin/bash
set -e

STAGE=$1
CONFIG_FILE="../config/${STAGE,,}_config.env"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration file not found: $CONFIG_FILE"
  exit 1
fi

source "$CONFIG_FILE"

echo "Launching EC2 for stage: $STAGE"

INSTANCE_ID=$(aws ec2 run-instances   --image-id $AMI_ID   --instance-type $INSTANCE_TYPE   --key-name $KEY_NAME   --security-group-ids $SECURITY_GROUP_ID   --subnet-id $SUBNET_ID   --associate-public-ip-address   --iam-instance-profile Name=$IAM_ROLE   --user-data file://../scripts/user_data.sh   --query "Instances[0].InstanceId"   --output text)

echo "Instance launched: $INSTANCE_ID"
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID   --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Your app is available at: http://$INSTANCE_IP"

echo "Waiting for $STOP_DELAY minutes before stopping instance..."
sleep $((STOP_DELAY * 60))

aws ec2 stop-instances --instance-ids $INSTANCE_ID
echo "Instance stopped."
