variable "aws_region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b"]
}

variable "backend_vm_count" {
  default = 2
}

variable "frontend_vm_count" {
  default = 2
}

variable "db_vm_count" {
  default = 2
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instances"
}
