resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "itwaswinter0204"

  tags = {
    Name        = "artifact-bucket"
  }
}