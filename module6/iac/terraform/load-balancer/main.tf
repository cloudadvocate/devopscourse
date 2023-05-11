
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "devopscourse-tf-state"
    key    = "bookmanager/lb-state.tf"
    region = "ap-south-1"
  }

}


data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "devopscourse-tf-state"
    key    = "bookmanager/instance-state.tf"
    region = "ap-south-1"
  }
}


provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "main" {
  default = true
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  
}


resource "aws_lb_target_group" "bookmanager_target_group" {
  name     = "bookmanager-target-group"
  port     = 8082
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.main.id
  health_check {
    enabled = true
    path    = "/api/"
    port    = 8082
  }
}


resource "aws_lb" "book_manager_lb" {
  name               = "book-manager-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.remote.outputs.security_group_id]
  subnets            = var.subnets
  
  enable_deletion_protection = false

  tags = {
    Name = "book-manager-lb"
  }
}

data "aws_acm_certificate" "book_manager_certificate" {
  domain   = "*.cloudadvocate.net"
  statuses = ["ISSUED"]
}

resource "aws_lb_listener" "book_manager_lb_listener" {
  load_balancer_arn = aws_lb.book_manager_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.book_manager_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookmanager_target_group.arn
  }
}


resource "aws_lb_listener_rule" "book_manager_lb_listener_rule" {
  listener_arn = aws_lb_listener.book_manager_lb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bookmanager_target_group.arn
  }

  condition {
    host_header {
      values = ["bookmanager.cloudadvocate.net"]
    }
  }
}





