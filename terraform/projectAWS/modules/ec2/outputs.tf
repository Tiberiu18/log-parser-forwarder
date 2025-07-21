output "instance_public_ip" {
  description = "Public IP of the EC2 Instance"
  value       = aws_instance.log-parser-forwarder.public_ip
}

output "instance_id" {
description = "EC2 Instance ID"
value = aws_instance.log-parser-forwarder.id

}
