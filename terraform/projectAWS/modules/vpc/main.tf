resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(var.tags, {
    Name = "vpc"
  })

}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.myvpc.id

  cidr_block = var.public_subnet_cidrs[0]

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "Public-Subnet"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id

  cidr_block              = var.private_subnet_cidrs[0]
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "Private-Subnet"
  })


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = merge(var.tags, {
    Name = "IGW"
  })


}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.public_subnet.id

  tags = merge(var.tags, {
    Name = "nat-gateway"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_security_group" "allow_ssh" {
	ingress {
		description = "Allow SSH from anywhere"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}


	egress {
	description = "Allow outbound connection to any address"
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]

}



}
