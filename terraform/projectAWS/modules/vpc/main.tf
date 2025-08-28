resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(var.tags, {
    Name = "vpc"
  })

}

locals {
  public_subnets = {
    for idx, az in var.availability_zones : az => {
      cidr = var.public_subnet_cidrs[idx]
    }
  }

  private_subnets = {
    for idx, az in var.availability_zones : az => {
      cidr = var.private_subnet_cidrs[idx]
    }
  }

}

resource "aws_subnet" "public_subnet" {
  for_each          = local.public_subnets
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = each.key
  cidr_block        = each.value.cidr

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "Public-Subnet-${each.key}"
  })
}

resource "aws_subnet" "private_subnet" {
  for_each                = local.private_subnets
  vpc_id                  = aws_vpc.myvpc.id
  availability_zone       = each.key
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = "Private-Subnet-${each.key}"
  })


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = merge(var.tags, {
    Name = "IGW"
  })


}

resource "aws_eip" "nat_eip" {
  for_each = local.public_subnets
  domain   = "vpc"
  tags = merge(var.tags, {
    Name = "nat-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "nat" {
  for_each      = local.public_subnets
  allocation_id = aws_eip.nat_eip[each.key].id

  subnet_id = aws_subnet.public_subnet[each.key].id

  tags = merge(var.tags, {
    Name = "nat-gateway-${each.key}"
  })
}

resource "aws_route_table" "public_rt" {
  for_each = aws_subnet.public_subnet

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "public-rt-${each.key}"
  })

}

resource "aws_route_table" "private_rt" {
  for_each = aws_nat_gateway.nat
  vpc_id   = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }

  tags = merge(var.tags, {
    Name = "private-rt-${each.key}"
  })
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt[each.key].id
}


resource "aws_route_table_association" "private_assoc" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private_rt[each.key].id
}


resource "aws_security_group" "allow_ssh" {
  for_each    = aws_subnet.public_subnet
  name        = "allow-ssh-${each.key}"
  vpc_id      = aws_vpc.myvpc.id
  description = "Allow SSH from anywhere and allow outbound to any address into public subnet ${each.key}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description = "Allow outbound connection to any address"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(var.tags, { Name = "sg-ssh-${each.key}" }
  )

}

