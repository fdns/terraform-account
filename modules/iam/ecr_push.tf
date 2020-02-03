resource "aws_iam_policy" "terraform_user_ecr_push" {
  name   = "terraform_user_ecr_push"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_ecr_push.json}"
}

data "aws_iam_policy_document" "terraform_user_ecr_push" {
  statement {
    actions = [
      "ecr:*"
    ]
    // Prevent users from downloading images
    /*not_actions = [
            "ecr:GetDownloadUrlForLayer"
            //"ecr:BatchGetImage",
            //"ecr:GetDownloadUrlForLayer"
        ]*/
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["us-east-2"]
    }
  }
}
