variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The type of instance to deploy"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the instance"
  type        = string
  default     = "ami-0fa3fe0fa7920f68e"
}

variable "instance_name" {
  description = "The name tag for the instance"
  type        = string
  default     = "MyTFInstance"
}

variable "vpc_name" {
  description = "The name for VPC"
  type        = string
  default     = "MyTFVPC"
}

variable "project_tag" {
  description = "The project tag for all resources"
  type        = string
  default     = "MyTerraformProject"
}

variable "app_sg_name" {
  description = "The security group to allow SSH and HTTP Traffic"
  type        = string
  default     = "app_sg_name"
}

variable "key_name" {
  description = "SSH Key Pair Name"
  type        = string
  default     = "my-key-pair"
}
