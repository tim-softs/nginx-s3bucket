resource "aws_vpc" "example" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name    = "${var.name} VPC"
    own_tag = "tt"
  }
}

resource "aws_internet_gateway" "default_igw" {
  vpc_id = "${aws_vpc.example.id}"

  tags = {
    # Name = "${var.name} VPC"
    Name    = "${var.name} IGW"
    own_tag = "tt"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.example.id}"
  # count      = "1"
  cidr_block = "192.168.0.0/24"
  tags = {
    Name    = "${var.name} Public subnet"
    own_tag = "tt"
  }
}

// Public routing
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.example.id}"

  tags = {
    Name    = "${var.name} Public Routes"
    own_tag = "tt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default_igw.id}"
}

resource "aws_route_table_association" "public" {
  count          = "1"
  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${aws_subnet.public.id}"
}
