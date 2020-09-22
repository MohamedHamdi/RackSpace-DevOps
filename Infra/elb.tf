## Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name = "security_group_for_elb"
  vpc_id = "${aws_vpc.default.id}"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Creating ELB
resource "aws_elb" "elb" {
  name = "elb"
  subnets = ["${aws_subnet.us-west-1b-public.id}","${aws_subnet.us-west-1c-public.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}