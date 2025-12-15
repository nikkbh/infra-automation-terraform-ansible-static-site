provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = var.vpc_name
    Project = var.project_tag
  }
}

# Create a subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name    = "${var.vpc_name}-public-subnet"
    Project = var.project_tag
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "app_vpc_ig" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name    = "${var.vpc_name}-ig"
    Project = var.project_tag
  }
}

# Create a public route table with Internet Gateway route
resource "aws_route_table" "app_public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_vpc_ig.id
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "app_public_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.app_public_rt.id
}

# Create a security group allowing SSH and HTTP access
resource "aws_security_group" "app_security_group" {
  name   = var.app_sg_name
  vpc_id = aws_vpc.app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = var.app_sg_name
    Project = var.project_tag
  }
}

# Create an EC2 instance with nginx installed
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.app_security_group.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name    = var.instance_name
    Project = var.project_tag
  }
}
