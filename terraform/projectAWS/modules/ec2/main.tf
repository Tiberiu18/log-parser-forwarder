
resource "aws_instance" "log-parser-forwarder" {
  key_name               = var.key_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data_path != "" ? var.user_data_path : null
  tags                   = var.tags
}

