terraform {
  backend "s3" {
    bucket         = "eks-bucket-tkc"
    key            = "backend/ToDo-App.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "dynamoDB-terra"
  }
}