output "guestbook_url" {
  value = "http://${aws_instance.web-proxy.public_ip}"
}
output "watchdog_url" {
  value = "http://${aws_instance.web-proxy.public_ip}/${var.watchdog.omd_site}/check_mk"
}
output "nat_ip" {
  value = "${aws_instance.nat.public_ip}"
}
