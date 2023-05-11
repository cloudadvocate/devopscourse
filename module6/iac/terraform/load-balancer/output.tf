
output "aws_lb_id" {
  description = "AWs LB Target Group ID"
  value       = aws_lb.book_manager_lb.id
}

output "aws_lb_arn" {
  description = "AWs LB Target Group ARN"
  value       = aws_lb.book_manager_lb.arn
}


output "aws_lb_target_group_arn" {
  description = "AWs LB Target Group ARN"
  value       = aws_lb_target_group.bookmanager_target_group.arn
}

