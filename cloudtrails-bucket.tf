# Account Identity
module "identity" {
  source = "git::git@github.com:sagansystems/tf_account.git?ref=tags/0.5.0"
}

module "s3_bucket" {
  source = "git::https://github.com/cloudposse/tf_log_storage.git?ref=tags/0.7.0"

  attributes = var.attributes
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags

  acl                                = var.acl
  region                             = var.region
  force_destroy                      = var.force_destroy
  lifecycle_rule_enabled             = var.lifecycle_rule_enabled
  versioning_enabled                 = var.versioning_enabled
  noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
  noncurrent_version_transition_days = var.noncurrent_version_transition_days
  standard_transition_days           = var.standard_transition_days
  glacier_transition_days            = var.glacier_transition_days
  expiration_days                    = var.expiration_days
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3_bucket.bucket_id
  policy = data.aws_iam_policy_document.cloudtrails.json
}

locals {
  bucket_path  = join("/", compact([var.prefix, "AWSLogs"]))
  account_list = sort(compact(concat([module.identity.account_id], var.accounts)))
}

data "aws_iam_policy_document" "cloudtrails" {
  statement {
    actions = [
      "s3:GetBucketAcl",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    resources = [
      module.s3_bucket.bucket_arn,
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    resources = formatlist(
      "%s/%s/%s/*", module.s3_bucket.bucket_arn, local.bucket_path, local.account_list
    )

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}
