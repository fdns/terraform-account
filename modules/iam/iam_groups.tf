resource "aws_iam_group" "terraform_developers" {
  name = "terraform_developers"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "developer-attach-developer" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_developer_ec2.arn}"
}


resource "aws_iam_group_policy_attachment" "developer-attach-s3admin" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_s3admin.arn}"
}


resource "aws_iam_group_policy_attachment" "developer-attach-usergeneral" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_general.arn}"
}

resource "aws_iam_group_policy_attachment" "developer-attach-ecr" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_ecr_push.arn}"
}

resource "aws_iam_group_policy_attachment" "developer-attach-cloud9" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_cloud9.arn}"
}

resource "aws_iam_group_policy_attachment" "developer-attach-ses" {
  group      = "${aws_iam_group.terraform_developers.name}"
  policy_arn = "${aws_iam_policy.terraform_user_ses.arn}"
}
