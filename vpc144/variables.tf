provider "aws" {}
# Required AWS settings expected in environment
# AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION

variable "vpc_name" {
  default = "vpc144"
}

variable "vpc_az1" {
  default = "us-east-2b"
}

variable "vpc_az2" {
  default = "us-east-2c"
}

variable "aws_key_name" {
  default = "devopswtf-test-key"
}

variable "aws_nat_ami" {
  default = "ami-07fdd962"
}

variable "aws_linux_ami" {
  default = "ami-ea87a78f"
}
