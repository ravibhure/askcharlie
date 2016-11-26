/* Deployment */

resource "null_resource" "ansible-provision" {

  depends_on = ["aws_instance.postgresql","aws_instance.redis","aws_instance.appserver"]

  ##Create PostgreSQL Inventory
  provisioner "local-exec" {
    command =  "echo \"[postgresql]\n${aws_instance.postgresql.public_ip} ansible_connection=ssh ansible_ssh_user=${var.conn_user}\" > inventory"
  }

  ##Create Redis Inventory
  provisioner "local-exec" {
    command =  "echo \"[redis]\n${aws_instance.redis.public_ip} ansible_connection=ssh ansible_ssh_user=${var.conn_user}\" >> inventory"
  }

  ##Create AppServer Inventory
  provisioner "local-exec" {
    command =  "echo \"[appserver]\n${aws_instance.appserver.public_ip} ansible_connection=ssh ansible_ssh_user=${var.conn_user}\" >> inventory"
  }

}

resource "null_resource" "guestbook" {
  depends_on = ["null_resource.ansible-provision"]
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${aws_instance.postgresql.public_ip}"
    user = "${var.conn_user}"
    key_file = "${var.key_path}"
    type = "ssh"
    timeout = "2m"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory database.yml --private-key ${var.key_path}"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory redis.yml --private-key ${var.key_path}"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory application.yml --extra-vars '{\"app_redis_host\":\"${aws_instance.redis.public_ip}\",\"app_db_host\":\"${aws_instance.postgresql.public_ip}\"}' --private-key ${var.key_path}"
  }
}
