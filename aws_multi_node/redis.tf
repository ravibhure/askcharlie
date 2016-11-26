# REDIS
resource "aws_instance" "redis" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.guestbook.id}"]
  associate_public_ip_address = true
  connection {
    user = "${var.conn_user}"
    key_file = "${var.key_path}"
  }
  key_name = "${var.key_name}"
  tags {
    Name = "redis"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get -y install software-properties-common",
        "sudo apt-get install python-pip python-dev git -y"
    ]
  }
}
