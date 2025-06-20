resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.myvpc.id
	
	tags = {
		Name = "IGW"
	}

	depends_on = [aws_internet_gateway.igw]

}
