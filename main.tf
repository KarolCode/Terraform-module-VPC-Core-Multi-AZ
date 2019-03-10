# VPC's:

resource "aws_vpc" "blog" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "GhostBlog"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}

# Internet Gates:

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.blog.id}"

  tags {
    Name = "VPC IGW Blog"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}

# Elastics IP's:

resource "aws_eip" "nat" {
  count = "${length(var.zones)}"
  vpc   = true

  tags {
    Name = "Elastic IP's ${count.index}"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}

# NAT Gateway:

resource "aws_nat_gateway" "nat" {

  count = "${length(var.zones)}"

  subnet_id = "${element(aws_subnet.dmz.*.id, count.index)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"

  tags {
    Name = "NAT Gateway ${count.index}"
    Managed_by = "${var.managed_by}"
    Environment = "${var.environment}"
  }
}