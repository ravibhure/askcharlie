variable "access_key" {}
variable "secret_key" {}
variable "key_path" {}
variable "key_name" {}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

# ubuntu-trusty-14.04 (x64)
variable "ec2_ami" {
  default = "ami-7f675e4f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "conn_user" {
  default = "ubuntu"
}

variable "key_name" {
  description = "Name of the SSH keypair to use in AWS."
  default = "ravi"
}

variable "key_path" {
  description = "Path to the private portion of the SSH key specified."
  default = "~/.ssh/ravi.pem"
}

