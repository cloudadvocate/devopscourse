variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-00976137ed6a39ee6","subnet-0d0cb84f67c3b070b","subnet-05b057862333fb020"]
}
