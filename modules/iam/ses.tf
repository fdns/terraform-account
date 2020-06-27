resource "aws_iam_policy" "terraform_user_ses" {
  name   = "terraform_user_ses"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_ses.json}"
}

data "aws_iam_policy_document" "terraform_user_ses" {
  statement {
    actions = [
      "ses:*"
    ]
    resources = [
      "*"
    ]
  }
}

# Create SES stmp user
resource "aws_iam_user" "ses" {
  name = "ses"
}

resource "aws_iam_access_key" "ses" {
  user = aws_iam_user.ses.name
}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.ses.ses_smtp_password
}

resource "aws_iam_policy" "terraform_user_ses_sendmail" {
  name   = "terraform_user_ses_sendmail"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_ses_sendmail.json}"
}

resource "aws_iam_user_policy_attachment" "terraform_user_ses_sendmail" {
  user       = "${aws_iam_user.ses.name}"
  policy_arn = "${aws_iam_policy.terraform_user_ses_sendmail.arn}"
}

data "aws_iam_policy_document" "terraform_user_ses_sendmail" {
  statement {
    actions = [
      "ses:SendRawEmail"
    ]
    resources = [
      "*"
    ]
  }
}
