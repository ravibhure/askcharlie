variable "nat" {
  description = "https://github.com/atsaki/tf_aws_nat_ami/blob/master/variables.tf.json"
  default = {
    # "us-east-1,amzn-ami-vpc-nat-hvm-2015.03.0.x86_64-ebs": "ami-b0210ed8",
    # "us-west-2,amzn-ami-vpc-nat-hvm-2015.03.0.x86_64-ebs": "ami-75ae8245",
    ami_image         = "ami-75ae8245"
    availability_zone = "unknown"
  }
}

variable "web-proxy" {
  default = {
    ami_image         = "ami-e54f5f84"
    ami_type          = "t2.micro"
    availability_zone = "unknown"
    count             = "1"
  }
}

variable "postgresql" {
  default = {
    ami_image         = "ami-e54f5f84"
    ami_type          = "t2.micro"
    availability_zone = "unknown"
    count             = "1"
  }
}

variable "redis" {
  default = {
    ami_image         = "ami-e54f5f84"
    ami_type          = "t2.micro"
    availability_zone = "unknown"
    count             = "1"
  }
}

variable "app" {
  default = {
    ami_image         = "ami-e54f5f84"
    ami_type          = "t2.micro"
    availability_zone = "unknown"
    count             = "1"
  }
}

variable "watchdog" {
  default = {
    ami_image         = "ami-e54f5f84"
    ami_type          = "t2.micro"
    availability_zone = "unknown"
  }
}

variable "global" {
  description = "Path to the private portion of the SSH key specified."
  default = {
    key_file          = "~/.ssh/ravi.pem"
  }
}
