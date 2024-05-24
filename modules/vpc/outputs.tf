output "public_subnets" {
  value = aws_subnet.public_subnets
}


output "vpc_id" {
  value = aws_vpc.vpc.id
}
