
resource "aws_s3_bucket" "test" {
  bucket = "test2-tkc"
  acl    = "private" # Adjust permissions as needed

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform Test Bucket"
  }
}
