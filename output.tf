output "dmz" {
  value = "${aws_subnet.dmz.*.id}"
}

output "resources" {
  value = "${aws_subnet.resources.*.id}"
}

output "vpc" {
  value = "${aws_vpc.blog.id}"
}

output "nat_epi" {
  value = "${aws_eip.nat.*.id}"
}

output "nat_epi_ips" {
  value = "${aws_eip.nat.*.public_ip}"
}