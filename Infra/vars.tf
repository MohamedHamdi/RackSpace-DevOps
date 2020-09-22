variable "aws_access_key" {
    default = "AKIA3Q56NSKEL7I6OEMH"
}
variable "aws_secret_key" {
    default = "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"
}
variable "aws_key_name" {
    default = "ec2accesskey"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-09a1a3cfa46061826"
        us-east-2 = "ami-04e70002c903255f5"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "public_subnet_cidr_2" {
    description = "CIDR for the Public Subnet"
    default = "10.0.3.0/24"
}


variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr_2" {
    description = "CIDR for the Private Subnet"
    default = "10.0.2.0/24"
}


variable "RDS_PASSWORD" {
    default = "MyRDSsimplePassword"
}



