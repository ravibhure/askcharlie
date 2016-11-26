resource "aws_instance" "nat" {
  ami                         = "${var.nat.ami_image}"
  availability_zone           = "${var.nat.availability_zone}"
  instance_type               = "${var.nat.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user = "${var.global.bastion_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-nat"
    Environment = "${var.environment_name}"
  }
}

resource "aws_instance" "redis" {
  depends_on                  = ["aws_instance.nat"]
  ami                         = "${var.redis.ami_image}"
  availability_zone           = "${var.redis.availability_zone}"
  instance_type               = "${var.redis.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  associate_public_ip_address = false
  source_dest_check           = true
  count                       = "${var.redis.count}"

  connection {
    bastion_user = "${var.global.bastion_name}"
    bastion_host = "${aws_instance.nat.public_ip}"
    bastion_private_key = "${var.global.key_file}"
    user = "${var.global.user_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-redis-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_instance" "postgresql" {
  depends_on                  = ["aws_instance.nat"]
  ami                         = "${var.postgresql.ami_image}"
  availability_zone           = "${var.postgresql.availability_zone}"
  instance_type               = "${var.postgresql.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  associate_public_ip_address = false
  source_dest_check           = true
  count                       = "${var.postgresql.count}"

  connection {
    bastion_user = "${var.global.bastion_name}"
    bastion_host = "${aws_instance.nat.public_ip}"
    bastion_private_key = "${var.global.key_file}"
    user = "${var.global.user_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-postgresql-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_instance" "app" {
  depends_on                  = ["aws_instance.postgresql","aws_instance.web-proxy","aws_instance.redis"]
  ami                         = "${var.app.ami_image}"
  availability_zone           = "${var.app.availability_zone}"
  instance_type               = "${var.app.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  associate_public_ip_address = false
  source_dest_check           = true
  count                       = "${var.app.count}"

  connection {
    bastion_user = "${var.global.bastion_name}"
    bastion_host = "${aws_instance.nat.public_ip}"
    bastion_private_key = "${var.global.key_file}"
    user = "${var.global.user_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-app-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_instance" "web-proxy" {
  ami                         = "${var.web-proxy.ami_image}"
  availability_zone           = "${var.web-proxy.availability_zone}"
  instance_type               = "${var.web-proxy.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.public.id}"]
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = true
  count                       = "${var.web-proxy.count}"

  connection {
    user = "${var.global.user_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-web-proxy-${count.index}"
    Environment = "${var.environment_name}"
  }
}

resource "aws_instance" "watchdog" {
  depends_on                  = ["aws_instance.nat"]
  ami                         = "${var.watchdog.ami_image}"
  availability_zone           = "${var.watchdog.availability_zone}"
  instance_type               = "${var.watchdog.ami_type}"
  key_name                    = "${var.global.key_name}"
  security_groups             = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private-subnet.id}"
  associate_public_ip_address = false
  source_dest_check           = true

  connection {
    bastion_user = "${var.global.bastion_name}"
    bastion_host = "${aws_instance.nat.public_ip}"
    bastion_private_key = "${var.global.key_file}"
    user = "${var.global.user_name}"
    key_file = "${var.global.key_file}"
  }

  tags {
    Name        = "${var.environment_name}-watchdog"
    Environment = "${var.environment_name}"
  }
}
