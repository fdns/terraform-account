resource "aws_iam_policy" "terraform_user_cloud9" {
  name   = "terraform_user_cloud9"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_cloud9.json}"
}

data "aws_iam_policy_document" "terraform_user_cloud9" {
  statement {
    actions = [
      "cloud9:*"
    ]
    resources = [
      "*"
    ]
  }
}

