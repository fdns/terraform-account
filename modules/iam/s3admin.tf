resource "aws_iam_policy" "terraform_user_s3admin" {
  name   = "terraform_user_s3admin"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_s3admin.json}"
}

data "aws_iam_policy_document" "terraform_user_s3admin" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["us-east-2"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "s3:LocationConstraint"
      values   = ["us-east-2"]
    }
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
}
