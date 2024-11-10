resource "aws_iam_role" "test-depends-on" {
    name = "test-depends-on"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
  
}

resource "aws_iam_instance_profile" "test-depends-on" {
    role = aws_iam_role.test-depends-on.name
  
}

resource "aws_iam_role_policy" "test-depends-on" {
    name   = "test-depends-on"
    role   = aws_iam_role.test-depends-on.name
    policy = jsonencode({
      "Version" = "2012-10-17"
      "Statement" = [
        {
          "Action"   = "s3:*"
          "Effect"   = "Allow"
          "Resource" = "*"
        }
      ]
    })
  
}

resource "aws_instance" "test-depends-on" {
     ami           = "ami-042e76978adeb8c48"
     instance_type = "t2.micro"

     iam_instance_profile = aws_iam_instance_profile.test-depends-on.name

     depends_on = [
        aws_iam_role_policy.test-depends-on
      ]
  
}