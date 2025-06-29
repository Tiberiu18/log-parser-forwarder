resource "aws_instance" "log-parser-forwarder" {
  key_name      = var.key_name
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = merge(var.tags, {
    Environment = "DEV"
  })

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound connection to any address"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # that means all protocols accepted
    cidr_blocks = ["0.0.0.0/0"]

  }


}


