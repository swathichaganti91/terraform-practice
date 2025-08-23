output "private_subnet_ids" {
  value = [aws_subnet.private.id, aws_subnet.private2.id]
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_id" {
  value = aws_subnet.main.id
  
}
output "private_subnet1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.private.id
}

output "private_subnet2_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.private2.id
}
