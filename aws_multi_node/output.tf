output "guestbook_url" {
  value = "http://${aws_instance.appserver.public_ip}"
}

output "postgresql" {
  value = "${aws_instance.postgresql.public_ip}"
}

output "redis" {
  value = "${aws_instance.redis.public_ip}"
}
