variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "ssh_keys" {}

# Specify the provider and access details

provider "digitalocean" {
  token = "${var.do_token}"
}

# RAILS SERVER
resource "digitalocean_droplet" "guestbook" {
  image = "${var.do_image}"
  name = "guestbook${count.index}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  private_networking = true
  count = 1
  ssh_keys = [
    "${var.ssh_keys}"
  ]

}

resource "null_resource" "guestbook" {
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = "${digitalocean_droplet.guestbook.ipv4_address}"
    user = "${var.conn_user}"
    key_file = "${var.pvt_key}"
    type = "ssh"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
        "apt-get update",
        "apt-get -y install software-properties-common",
        "apt-get install python-pip python-dev git -y"
    ]
  }

  provisioner "local-exec" {
    command = "echo \"[guestbook]\n${digitalocean_droplet.guestbook.ipv4_address} ansible_connection=ssh ansible_ssh_user=${var.conn_user}\" > inventory &&  ansible-playbook -i inventory site.yml --private-key ${var.pvt_key}"
  }
}
