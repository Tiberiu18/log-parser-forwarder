output "vpc_id" {
	description = "VPC ID"
	value = aws_vpc.myvpc.id
}

output "public_subnet_id" {
	description = "Public Subnet ID"
	value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
	description = "Private subnet id"
	value = aws_subnet.private_subnet.id
}

output "public_route_table_id" {
	description = "Public route table ID"
	value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
	description = "Private route table ID"
	value = aws_route_table.private_rt.id
	
}

output "internet_gateway_id" {
	description = "IGW ID"
	value = aws_internet_gateway.igw.id
}

output "nat_gateway_id" {
	description = "Nat Gateway ID"
	value = aws_nat_gateway.nat.id
}
