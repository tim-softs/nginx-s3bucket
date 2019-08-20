# Get AMI
data "aws_ami" "amzn_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }
}

# Create an EC2 instance
resource "aws_instance" "nginx_s3_app" {
  ami                         = "${data.aws_ami.amzn_linux.image_id}"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.nginx_s3_app.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  user_data                   = "${data.template_file.user_data.rendered}"
  key_name                    = "${var.key_pair_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.s3access_profile.name}"
  associate_public_ip_address = true

  lifecycle {
    ignore_changes = ["ami"]
  }

  tags = {
    Name    = "${var.name} EC2"
    own_tag = "tt"
  }
  volume_tags = {
    own_tag = "tt"
  }
}

# A User Data script that will run when the EC2 instance boots up and install Docker
data "template_file" "user_data" {
  template = "${file("${path.module}/user-data.sh")}"

  vars = {
    port        = "${var.port}"
    bucket_name = "${var.bucket_name}"

  }
}

# A Security Group that controls what network traffic can go in and out of the EC2 instance
resource "aws_security_group" "nginx_s3_app" {
  name        = "${var.name}"
  vpc_id      = "${aws_vpc.example.id}"
  description = "A Security Group for ${var.name}"

  # Inbound HTTP from anywhere
  ingress {
    from_port   = "${var.port}"
    to_port     = "${var.port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound everything
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.name} Security Group"
    own_tag = "tt"
  }
}
