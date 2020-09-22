## Creating Launch Configuration
resource "aws_launch_configuration" "as_launch_config" {
    name_prefix = "web-"
    image_id = "${lookup(var.amis, var.aws_region)}"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    security_groups = ["${aws_security_group.web_sg.id}"]
    associate_public_ip_address = true
}


## Creating AutoScaling Group
resource "aws_autoscaling_group" "web_as_group" {
  launch_configuration = "${aws_launch_configuration.as_launch_config.id}"
  vpc_zone_identifier       = ["${aws_subnet.us-west-1b-public.id}","${aws_subnet.us-west-1c-public.id}"]
  min_size = 6
  max_size = 12
  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "ELB"
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
}


## SG for web instances
resource "aws_security_group" "web_sg" {
name = "security_group_for_web_server"
vpc_id = "${aws_vpc.default.id}"
ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
}
ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_sg.id}"]
    }
ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
    }
egress { # MySQL
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
    }
 tags = {
        Name = "WebServerSG"
    }
}