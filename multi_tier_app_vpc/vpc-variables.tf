variable "vpc" {
  default = {
    owner_id = "ravi"
    cidr_block = "10.0.0.0/16"
  }
}
variable "vpc_public_subnet" {
  default = {
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-west-2a"
    map_public_ip_on_launch = "true"
  }
}
variable "vpc_private_subnet" {
  default = {
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2a"
  }
}
