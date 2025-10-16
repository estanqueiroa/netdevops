
# Additional provider configuration for us-east-1
# provider "aws" {
#  alias  = "east"
#  region = "us-east-1"
#  assume_role {
#    role_arn     = "arn:aws:iam::024160893228:role/network-deployment-role"
#  }
#}

#################
# Define the IAM role for main region
resource "aws_iam_role" "my_ec2_role" {
  name               = "my-ec2-role-new011"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  description = "IAM role for EC2 instances"
}

# (Optional) Attach a managed policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_read_only" {
  role       = aws_iam_role.my_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# (Optional) Create an instance profile for EC2
resource "aws_iam_instance_profile" "my_ec2_profile" {
  name = "ec2-instance-profile-new011"
  role = aws_iam_role.my_ec2_role.name
}

# Output the ARN of the created role
output "iam_role_arn" {
  value = aws_iam_role.my_ec2_role.arn
}

#############

# create VPC in second region US-EAST-1
#resource "aws_vpc" "east" {
#  provider             = aws.east
#  cidr_block           = "10.0.0.0/16"
#  enable_dns_hostnames = true
#  enable_dns_support   = true

#  tags = {
#    Name = "aft-vpc-2nd-region-55"
#  }
#}

# create VPC in main region SP
resource "aws_vpc" "saopaulo" {
  #provider             = aws.east
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "aft-vpc-main-region-sp-55-new011"
  }
}

