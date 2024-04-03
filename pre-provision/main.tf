# File: backend_resources.tf

provider "aws" {
  region = "eu-west-3" # Update with your desired region
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "eks-bucket-tkc"
  acl    = "private" # Adjust permissions as needed

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "dynamoDB-terra"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}
