provider "aws" {
  region = var.region
}

resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr_block

}

resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route_table" "public_rt" {
vpc_id = aws_vpc.test_vpc.id

route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}

}

resource "aws_route_table_association" "public_assoc" {
subnet_id = aws_subnet.test_public_subnet.id
route_table_id = aws_route_table.public_rt.id


}

resource "aws_subnet" "test_public_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

}

resource "aws_security_group" "test_sg" {
  vpc_id = aws_vpc.test_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]



  }
}

resource "aws_key_pair" "test_key" {
  key_name   = "test-key"
  public_key = file("~/.ssh/id_rsa.pub")
}



module "ec2" {
  vpc_id             = aws_vpc.test_vpc.id
  profile            = var.profile
  source             = "../"
  key_name           = var.key_name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  availability_zone  = var.availability_zone
  public_subnet_id   = aws_subnet.test_public_subnet.id
  security_group_ids = [aws_security_group.test_sg.id]

  attach_ebs      = true
  ebs_volume_size = 3


  user_data = file("${path.module}/user_data.sh")
  tags = merge(var.tags, {
    EBS_Attached = "Yes"
  })

}


