resource "aws_iam_role" "s3access_role" {
  name = "s3access_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    own_tag = "tt"
  }
}

resource "aws_iam_instance_profile" "s3access_profile" {
  name = "s3access_profile"
  role = "${aws_iam_role.s3access_role.name}"
}

resource "aws_iam_role_policy" "s3access_policy" {
  name = "s3access_policy"
  role = "${aws_iam_role.s3access_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
