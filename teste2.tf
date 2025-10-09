# Define the IAM role
resource "aws_iam_role" "my_ec2_role" {
  name               = "my-ec2-role22"
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
  name = "my-ec2-instance-profile"
  role = aws_iam_role.my_ec2_role.name
}

# Output the ARN of the created role
output "iam_role_arn" {
  value = aws_iam_role.my_ec2_role.arn
}
