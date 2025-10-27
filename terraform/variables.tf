variable "project_name" {
  description = "Prefix to apply to named resources"
  type        = string
  default     = "bastion-vpn-demo"
}

variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "trusted_cidr" {
  description = "Your public IP /32 for VPN+SSH (break-glass)"
  type        = string
  default     = "1.2.3.4/32"
}

variable "instance_type_bastion" {
  description = "Instance type for bastion"
  type        = string
  default     = "t3.micro"
}

variable "instance_type_private" {
  description = "Instance type for private EC2"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Owner       = "demo"
    Project     = "bastion-openvpn"
    Environment = "dev"
  }
}
