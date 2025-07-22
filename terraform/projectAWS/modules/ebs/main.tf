resource "aws_ebs_volume" "extra-volume" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  encrypted         = var.encrypted

}

resource "aws_volume_attachment" "attach" {
  device_name  = var.device_name
  volume_id    = aws_ebs_volume.extra-volume.id
  instance_id  = var.instance_id
  force_detach = true


}
