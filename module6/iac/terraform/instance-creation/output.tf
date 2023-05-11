output "security_group_id" {
  description = "Security Group Id of aws instance created"
  value       = aws_security_group.allow_tcp_8082.id
}