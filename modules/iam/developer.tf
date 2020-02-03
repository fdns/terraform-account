resource "aws_iam_policy" "terraform_user_developer_ec2" {
  name   = "terraform_user_developer_ec2"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_developer_ec2.json}"
}

data "aws_iam_policy_document" "terraform_user_developer_ec2" {
  statement {
    actions = [
      "ec2:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestedRegion"
      values   = ["us-east-2"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "ec2:AvailabilityZone"
      values   = ["us-east-2a"]
    }
  }

  statement {
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTag"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestedRegion"
      values   = ["us-east-2"]
    }
  }

  statement {
    effect = "Deny"
    actions = [
      "ec2:Purchase*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "ec2:Describe*",
      "ec2:Export*",
      "ec2:Get*",
      "ec2:Search*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets"
    ]
    resources = [
      "*"
    ]
  }

  // Prevent the deletion of protected resources
  statement {
    effect = "Deny"
    actions = [
      "ec2:Delete*",
      "ec2:TerminateInstances",
      "ec2:ReleaseAddress",
      "s3:Delete*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/protected"
      values   = ["true"]
    }
  }

  // Allow reading CloudWatch events globally
  statement {
    actions = [
      "autoscaling:Describe*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "logs:Get*",
      "logs:List*",
      "logs:Describe*",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents",
      "sns:Get*",
      "sns:List*",
      "compute-optimizer:*"
    ]
    resources = [
      "*"
    ]
  }
}
