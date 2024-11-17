terraform {
  backend "s3" {
    bucket = "demo-app-v2"
    region = "ap-southeast-1"
    key = "jenkins-server/terraform.tfstate"
  }
}
