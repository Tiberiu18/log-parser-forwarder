output "instance_public_ip" {
  description = "Public IP of the EC2 Instance"
  value       = module.ec2.instance_public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = module.ec2.instance_id

}

output "ec2_login_user" {
  value = module.ec2.ec2_login_user
}


output "ec2_private_key_path" {
  value = module.ec2.ec2_private_key_path


}
