output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.myvpc.id
}

output "public_subnet_ids" {
  description = "Public Subnet ID"
  value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  description = "Private subnet id"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "public_route_table_ids" {
  description = "Public route table ID"
  value       = [for route in aws_route_table.public_rt : route.id]
}

output "private_route_table_ids" {
  description = "Private route table ID"
  value       = [for route in aws_route_table.private_rt : route.id]

}

output "internet_gateway_id" {
  description = "IGW ID"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_ids" {
  description = "Nat Gateway ID"
  value       = [for nat in aws_nat_gateway.nat : nat.id]
}

output "security_group_ids" {
  description = "Allow ssh security group"
  value       = [for sg in aws_security_group.allow_ssh : sg.id]

}
