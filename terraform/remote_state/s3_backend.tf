variable "bucket_name" {
  default = "my-users-app-2021-tfstate"
}

variable "db_table" {
  default = "apps-backend-tfstatelock"
}

variable "user_name" {
  default = "terraform"
}

provider "aws" {}

data "aws_iam_user" "terraform" {
  user_name = var.user_name
}

resource "aws_s3_bucket" "tfremotestate" {
  bucket = var.bucket_name
  force_destroy = true
  acl = "private"

  versioning {
    enabled = true
  }

  # Grant read/write access to the terraform user
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_iam_user.terraform.arn}"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "tfremotestate" {
  bucket = aws_s3_bucket.tfremotestate.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_db_statelock" {
  name           = var.db_table
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user_policy" "terraform_user_dbtable" {
  name = var.user_name
  user = data.aws_iam_user.terraform.user_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["dynamodb:*"],
            "Resource": [
                "${aws_dynamodb_table.tf_db_statelock.arn}"
            ]
        }
   ]
}
EOF
}