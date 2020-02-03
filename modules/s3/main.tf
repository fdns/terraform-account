resource "aws_s3_bucket" "terraform_state" {
  bucket = "fdns-terraform-state"
  region = "us-east-2"
  acl    = "private"

  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1
  }

  versioning {
    enabled = true
  }

  tags = {
    project   = "cloud"
    protected = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_policy" {
  bucket                  = "${aws_s3_bucket.terraform_state.id}"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
