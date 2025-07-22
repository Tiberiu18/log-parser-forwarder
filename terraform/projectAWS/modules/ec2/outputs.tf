output "instance_public_ip" {
  description = "Public IP of the EC2 Instance"
  value       = aws_instance.log-parser-forwarder.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.log-parser-forwarder.id
}

output "ec2_login_user" {
  value = local.login_user
}

output "ec2_private_key_path" {
  value       = "${path.module}/id_rsa"
  description = "Local path to SSH private key file used for connecting to EC2"

}

output "ec2_login_user" {
value = local.login_user
}
