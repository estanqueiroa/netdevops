# Main provider configuration
provider "aws" {
  region = "sa-east-1"
}

# Additional provider configuration for us-east-1
provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

#################
# Define the IAM role for main region
resource "aws_iam_role" "my_ec2_role" {
  name               = "my-ec2-role33"
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
  name = "ec2-instance-profile-33"
  role = aws_iam_role.my_ec2_role.name
}

# Output the ARN of the created role
output "iam_role_arn" {
  value = aws_iam_role.my_ec2_role.arn
}


# Define the IAM role for US region
resource "aws_iam_role" "my_ec2_role_usregion" "east" {
  name               = "my-ec2-role33-usregion"
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
