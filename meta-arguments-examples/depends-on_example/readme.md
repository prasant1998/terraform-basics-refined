The first block defines and iam role that can be assumed by ec2 instance. The assume_role_policy allows EC2 instances to assume this role.
The second block creates an instance profile associated with the IAM role. An instance profile is a container for an IAM role that allows EC2 instances to use the role’s permissions.
The third block defines an inline policy attached to the test-depends-on role. The policy allows access to all S3 actions on all resources.
The last block provisions an EC2 instance with the specified Amazon Machine Image (AMI) and instance type. It also associates the IAM instance profile and specifies a dependency on the role policy.

depends_on: Ensures that the aws_iam_role_policy is created before the EC2 instance is launched, ensuring the permissions are available to the instance at boot time.

depends_on should only be used when Terraform’s automatic dependency tracking isn’t sufficient.