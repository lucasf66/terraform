resource "aws_s3_bucket" "bucket_state" {
  bucket = "zoune-remotestate"
  tags   = local.tags
}

resource "aws_s3_bucket_versioning" "bucket_state_versioning" {
  bucket = aws_s3_bucket.bucket_state.id
  versioning_configuration {
    status = "Enabled"
  }
}