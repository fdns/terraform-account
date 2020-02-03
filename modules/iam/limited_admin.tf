resource "aws_iam_policy" "terraform_limited_admin" {
  name   = "terraform_limited_admin"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_limited_admin.json}"
}

data "aws_iam_policy_document" "terraform_limited_admin" {
  statement {
    actions = [
      "organizations:*",
      "iam:*",
      "aws-portal:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_group" "terraform_limited_admin" {
  name = "terraform_limited_admin"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "terraform_limited_admin" {
  group      = "${aws_iam_group.terraform_limited_admin.name}"
  policy_arn = "${aws_iam_policy.terraform_limited_admin.arn}"
}
