variable "aws_access_key" {
    default = ""
}
variable "aws_secret_key" {
    default = ""
}
variable "aws_key_name" {
    default = "ec2accesskey" # After generating key pairs in AWS 
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-west-1 = "" # change to new one from Packer build process 
        us-east-2 = "" # change to new one from Packer build process 
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



