# aws_iam_role.QuickSetupSSMForEC2:
resource "aws_iam_role" "QuickSetupSSMForEC2" {
    assume_role_policy    = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
    managed_policy_arns   = [
        "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

    ]
    name          	 = "QuickSetupSSMForEC2"
    path                 = "/"
    description		 = "Allow access in EC2 instances by Session Manager"
    tags = {
      Service              = var.service_name
      Environment 	   = "${terraform.workspace}"
      ManagedByTerraform   = "true"
    }
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm_instance_profile"
  role = aws_iam_role.QuickSetupSSMForEC2.name
}
