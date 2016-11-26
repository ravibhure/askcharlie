variable "access_key" {}
variable "secret_key" {}
# Specify the provider and access details

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

# Our default security group to access
resource "aws_security_group" "guestbook" {
  name = "guestbook_sg"
  description = "Used in the guestbook"

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # PG access
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # redis access
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
