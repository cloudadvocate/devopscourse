terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "devopscourse-tf-state"
    key    = "bookmanager/autoscaling-state.tf"
    region = "ap-south-1"
  }

}

provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "devopscourse-tf-state"
    key    = "bookmanager/lb-state.tf"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "instance-creation" {
  backend = "s3"
  config = {
    bucket = "devopscourse-tf-state"
    key    = "bookmanager/instance-state.tf"
    region = "ap-south-1"
  }
}

data "aws_ami" "bookmanager_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["bookmanager-*"]
  }

  owners = ["363267848264"]
}

resource "aws_launch_template" "bookmanager-launch-template" {

  name = "bookmanager-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 10
    }
  }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  image_id = data.aws_ami.bookmanager_ami.id

  instance_type = "t3.micro"

  key_name = "devopscourse"

  vpc_security_group_ids = [data.terraform_remote_state.instance-creation.outputs.security_group_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bookmanager-launch-template"
    }
  }

}

resource "aws_autoscaling_group" "bookmanager-launch-group" {
  availability_zones = ["ap-south-1a","ap-south-1b"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.bookmanager-launch-template.id
    version = "$Latest"
  }
}


resource "aws_autoscaling_attachment" "bookmanager-launch-attachment-target-group" {
  autoscaling_group_name = aws_autoscaling_group.bookmanager-launch-group.id
  lb_target_group_arn    = data.terraform_remote_state.remote.outputs.aws_lb_target_group_arn
}



