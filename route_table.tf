# Route Table:

resource "aws_route_table" "dmz" {
  vpc_id = "${aws_vpc.blog.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "DMZ Route"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "resources" {
  vpc_id = "${aws_vpc.blog.id}"

  count = "${length(var.zones)}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags {
    Name = "Route Resources ${count.index}"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}


# Association:

resource "aws_route_table_association" "dmz_association" {

  count = "${length(var.zones)}"
  subnet_id = "${element(aws_subnet.dmz.*.id, count.index)}"

  route_table_id = "${aws_route_table.dmz.id}"
}

resource "aws_route_table_association" "resources_association" {

  count = "${length(var.zones)}"

  subnet_id = "${element(aws_subnet.resources.*.id, count.index)}"

  route_table_id = "${element(aws_route_table.resources.*.id, count.index)}"
}