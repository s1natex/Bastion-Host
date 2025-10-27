output "bastion_eip" {
  description = "Public Elastic IP for OpenVPN connection"
  value       = aws_eip.bastion_eip.public_ip
}

output "private_instance_private_ip" {
  description = "Private IP of the target EC2"
  value       = aws_instance.private_host.private_ip
}

output "private_key_pem" {
  description = "Generated SSH private key, save locally and chmod 400"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
