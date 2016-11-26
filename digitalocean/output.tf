output "guestbook_url" {
  value = "http://${digitalocean_droplet.guestbook.ipv4_address}"
}
