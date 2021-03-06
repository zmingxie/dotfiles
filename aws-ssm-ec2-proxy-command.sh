#!/usr/bin/env sh

######## Usage #################################################################
#
# #1 Install the AWS CLI
#   https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
#
# #2 Install the Session Manager Plugin for the AWS CLI
#   https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html
#
# #3 Install ProxyCommand
#   - Move this script to ~/.ssh/aws-ssm-ec2-proxy-command.sh
#   - Make it executable (chmod +x ~/.ssh/aws-ssm-ec2-proxy-command.sh)
#
# #4 Setup SSH Config
#   - Add foolowing entry to your ~/.ssh/config
#   - Adjust key file path if needed
#
#   host i-* mi-*
#     IdentityFile ~/.ssh/id_rsa
#     ProxyCommand ~/.ssh/aws-ssm-ec2-proxy-command.sh %h %r %p ~/.ssh/id_rsa.pub
#     StrictHostKeyChecking no
#
# #5 Ensure SSM Permissions fo Target Instance Profile
#
#   https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-profile.html
#
# #6 Ensure latest SSM Agent on Target Instance
#
#   yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm & service amazon-ssm-agent restart
#
# #7 Open SSH Connection
#   - Ensure AWS CLI environemnt variables are set properly
#
#   ssh <INSTACEC_USER>@<INSTANCE_ID>
#
#   e.g. AWS_PROFILE='default' ssh ec2-user@i-xxxxxxxxxxxxxxxx
#
#   - If default region does not match instance region you need to provide it like this
#
#   ssh <INSTACEC_USER>@<INSTANCE_ID>::<INSTANCE_REGION>
#
################################################################################
set -eu

REGION_SEPARATOR='--'

ec2_instance_id="$1"
ssh_user="$2"
ssh_port="$3"
ssh_public_key_path="$4"

if [[ "${ec2_instance_id}" = *${REGION_SEPARATOR}* ]]
then
  aws_region="${ec2_instance_id##*${REGION_SEPARATOR}}"
  ec2_instance_id="${ec2_instance_id%%${REGION_SEPARATOR}*}"
fi

instance_availability_zone="$(aws --region "$aws_region" ec2 describe-instances \
    --instance-id "$ec2_instance_id" \
    --query "Reservations[0].Instances[0].Placement.AvailabilityZone" \
    --output text)"

echo "Add public key ${ssh_public_key_path} to instance ${ec2_instance_id} for 60 seconds" >/dev/tty
aws --region "$aws_region" ec2-instance-connect send-ssh-public-key  \
  --instance-id "$ec2_instance_id" \
  --instance-os-user "$ssh_user" \
  --ssh-public-key "file://$ssh_public_key_path" \
  --availability-zone "$instance_availability_zone"

echo "Start ssm session to instance ${ec2_instance_id}" >/dev/tty
aws --region "$aws_region" ssm start-session \
  --target "${ec2_instance_id}" \
  --document-name 'AWS-StartSSHSession' \
  --parameters "portNumber=${ssh_port}"
