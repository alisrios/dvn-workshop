data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["dvn-workshop-vpc"]
  }
}