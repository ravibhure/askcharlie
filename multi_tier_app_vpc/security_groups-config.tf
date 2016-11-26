resource "aws_security_group" "nat" {
  name = "${var.environment_name}-nat"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # postgresql access from anywhere in vpc
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # redis access from anywhere in vpc
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # Check_MK access from anywhere in vpc
  ingress {
    from_port = 6556
    to_port = 6556
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }

  vpc_id = "${aws_vpc.environment.id}"
  tags {
    Name        = "${var.environment_name}-nat-security-group"
    Environment = "${var.environment_name}"
  }
}

resource "aws_security_group" "public" {
  name = "${var.environment_name}-public"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # postgresql access from anywhere in vpc
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # redis access from anywhere in vpc
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # Check_MK access from anywhere in vpc
  ingress {
    from_port = 6556
    to_port = 6556
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }

  vpc_id = "${aws_vpc.environment.id}"
  tags {
    Name        = "${var.environment_name}-public-security-group"
    Environment = "${var.environment_name}"
  }
}

resource "aws_security_group" "private" {
  name = "${var.environment_name}-private"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # Check_MK access from anywhere in vpc
  ingress {
    from_port = 6556
    to_port = 6556
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  # Guacd access from anywhere in vpc
  ingress {
    from_port = 4822
    to_port = 4822
    protocol = "tcp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc.cidr_block}"]
  }

  vpc_id = "${aws_vpc.environment.id}"
  tags {
    Name        = "${var.environment_name}-private-security-group"
    Environment = "${var.environment_name}"
  }
}
