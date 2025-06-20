resource "aws_route_table" "public_rt" {
	vpc_id = aws_vpc.myvpc.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}
	
}

resource "aws_route_table" "private_rt" {
	vpc_id = aws_vpc.vpc.id

	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = aws_nat_gateway.nat.id
	}
}

resource "aws_route_table_association" "public_assoc" {
	subnet_id = aws_subnet.public_subnet.id
	route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "private_assoc" {
	subnet_id = aws_subnet.private_subnet.id
	route_table = aws.route_table.private_rt.id
}
