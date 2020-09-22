/*
  Database Servers
*/
resource "aws_security_group" "db" {
    name = "vpc_db"
    description = "Allow incoming database connections."

    ingress { # MySQL
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.web_sg.id}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.public_subnet_cidr}"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.public_subnet_cidr}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags = {
        Name = "DBServerSG"
    }
}


resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.us-west-1b-private.id,aws_subnet.us-west-1c-private.id]
  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "db-1" {
    allocated_storage = 20 # 100 GB of storage, gives us more IOPS than a lower number
    engine = "mariadb"
    engine_version = "10.1.14"
    identifier = "mariadb"
    name = "mariadb"
    instance_class = "db.t2.small" # use micro if you want to use the free tier
    username = "root" # username
    password = "${var.RDS_PASSWORD}" # password
    multi_az = "true" # set to true to have high availability: 2 instances synchronized with each other
    #availability_zone = "us-west-1b"
    db_subnet_group_name = "${aws_db_subnet_group.default.id}" 
    vpc_security_group_ids = ["${aws_security_group.db.id}"]
    storage_type = "gp2"
    backup_retention_period = 30 # how long you’re going to keep your backups
    tags = {
        Name = "DB Server 1"
    }
}