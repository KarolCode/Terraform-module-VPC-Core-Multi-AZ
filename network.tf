# Private networks:

resource "aws_subnet" "resources" {
  count = "${length(var.zones)}"

  vpc_id = "${aws_vpc.blog.id}"

  availability_zone = "${element(var.zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, var.network_size, count.index + var.networks_space)}"

  tags {
    Name = "Resources ${count.index}"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}

# Public Networks:

resource "aws_subnet" "dmz" {
  count = "${length(var.zones)}"

  vpc_id = "${aws_vpc.blog.id}"

  availability_zone = "${element(var.zones, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, var.network_size, count.index)}"

  tags {
    Name = "DMZ ${count.index}"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}