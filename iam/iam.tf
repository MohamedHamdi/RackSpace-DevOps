provider "aws" {
  region = "us-west-1"
  access_key = "AKIA3Q56NSKEL7I6OEMH"
  secret_key = "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"
}


resource "aws_iam_role" "s3role" {
  name = "s3role"

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
      tag-key = "tag-value"
  }
}


resource "aws_iam_instance_profile" "s3profile" {
  name = "s3profile"
  role = "${aws_iam_role.s3role.name}"
}

resource "aws_iam_role_policy" "s3policy" {
  name = "s3policy"
  role = "${aws_iam_role.s3role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "role-s3" {
  ami = "ami-0f94f4b272b3af7b8"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.s3profile.name}"
  key_name = "ec2accesskey"
}