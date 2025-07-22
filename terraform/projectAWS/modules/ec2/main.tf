resource "aws_key_pair" "ec2_key" {
key_name = "demo-key"
public_key = tls_private_key.ec2_key.public_key_openssh

}



resource "aws_instance" "log-parser-forwarder" {
  key_name               = aws_key_pair.ec2_key.key_name
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data_path != "" ? var.user_data_path : null
  tags                   = var.tags
}

