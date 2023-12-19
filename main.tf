terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      Environment = "dev"
      Purpose     = "Interview"
    }
  }
}

resource "aws_vpc" "primary" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Primary"
  }
}

resource "aws_subnet" "web" {
  cidr_block        = "192.168.1.0/24"
  vpc_id            = aws_vpc.primary.id
  availability_zone = "ap-south-1a"
  tags = {
    Name = "web"
  }
  depends_on = [aws_vpc.primary]
}

resource "aws_subnet" "data" {
  cidr_block        = "192.168.2.0/24"
  vpc_id            = aws_vpc.primary.id
  availability_zone = "ap-south-1b"
  tags = {
    Name = "data"
  }
  depends_on = [aws_vpc.primary]
}

resource "aws_subnet" "business" {
  cidr_block = "192.168.3.0/24"
  vpc_id     = aws_vpc.primary.id
  tags = {
    Name = "business"
  }
  depends_on = [aws_vpc.primary]
}

resource "aws_s3_bucket" "testing" {

}