# Bastion-Host
- A bastion host for managing access to private infrastructure
```
This project demonstrates how to set up a bastion host in an AWS environment to securely access a private server that is not publicly accessible. The bastion host acts as a secure gateway to the private server, minimizing the attack surface by funneling all external access through a single point
```
# Project Page
```
https://roadmap.sh/projects/bastion-host
```
# Setup instructions:
- Create VPC, Subnets and internet gateway with aws cli
```
aws ec2 create-vpc --cidr-block 10.0.0.0/16

aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24
aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24

aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID
```
- Setup Security Group
```
aws ec2 create-security-group --group-name bastion-sg \
  --description "Security group for bastion host" --vpc-id $VPC_ID

aws ec2 create-security-group --group-name private-sg \
  --description "Security group for private instance" --vpc-id $VPC_ID
```
- Launch EC2 instance and Bastion Host
```
aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro \
  --key-name your-key-name --security-group-ids $BASTION_SG_ID \
  --subnet-id $PUBLIC_SUBNET_ID

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro \
  --key-name your-key-name --security-group-ids $PRIVATE_SG_ID \
  --subnet-id $PRIVATE_SUBNET_ID
```
- SSH Configuration
```
# SSH configuration file on your local machine (~/.ssh/config)
Host bastion
    HostName <bastion-public-ip>
    User ec2-user
    IdentityFile ~/.ssh/bastion-key.pem

Host private-server
    HostName <private-server-private-ip>
    User ec2-user
    ProxyJump bastion
    IdentityFile ~/.ssh/private-server-key.pem
```
- Connect to the Bastion Host
```
ssh bastion
```
- Connect to the Private Server through Bastion
```
ssh private-server
```
- On bastion host install fail2ban
```
sudo yum update -y
sudo yum install epel-release -y
sudo yum install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```
# Troubleshooting
- Check your Security Group settings if you cannot connect
- Verify that your private key file permissions are correct