resource "aws_iam_policy" "terraform_user_general" {
  name   = "terraform_user_general"
  path   = "/"
  policy = "${data.aws_iam_policy_document.terraform_user_general.json}"
}

data "aws_iam_policy_document" "terraform_user_general" {
  statement {
    actions = [
      "iam:GetAccountPasswordPolicy",
      "sts:DecodeAuthorizationMessage",
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "iam:GetUser",
      "iam:ChangePassword",
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
      "arn:aws:iam::*:mfa/&{aws:username}",
    ]
  }

  statement {
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"
    ]

    resources = [
      "arn:aws:iam::*:user/&{aws:username}",
    ]
  }

  // Prevent users without 2fa
  statement {
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken"
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
    condition {
      test     = "StringNotEqualsIfExists"
      variable = "aws:Resource"
      values = ["role/aws-ec2-spot-fleet-tagging-role"]
    }
  }
}
