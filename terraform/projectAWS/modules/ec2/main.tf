
resource "aws_instance" "log-parser-forwarder" {
  key_name               = var.key_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data != "" ? var.user_data : null
  tags                   = var.tags
}

resource "aws_ebs_volume" "extra" {
  count             = var.attach_ebs ? 1 : 0
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  tags = merge(var.tags, {
    Name = "extra-volume"
  })

}

resource "aws_volume_attachment" "attach" {
  count       = var.attach_ebs ? 1 : 0
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.extra[0].id
  instance_id = aws_instance.log-parser-forwarder.id


}


