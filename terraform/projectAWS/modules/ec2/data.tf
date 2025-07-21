data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250610"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


locals {
  ami_name = data.aws_ami.ubuntu.name

  login_user = (
    can(regex("ubuntu", local.ami_name)) ? "ubuntu" :
    can(regex("amzn2", local.ami_name)) ? "ec2-user" :
    can(regex("centos", local.ami_name)) ? "centos" :
    can(regex("debian", local.ami_name)) ? "admin" :
    "unknown"
  )







}
