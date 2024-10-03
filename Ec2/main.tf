resource "aws_instance" "preprod" {
    ami = "ami-0b72821e2f351e396"
    instance_type = "t2.micro"
    security_groups = [var.sg]
    subnet_id = var.pu_sb
  tags = {
    name = "preprod"
  }

}
resource "aws_instance" "prod" {
    ami = "ami-0b72821e2f351e396"
    instance_type = "t2.micro"
    security_groups = [var.sg]
    subnet_id = var.pr_sb
  tags ={
    name = "prod"
  }

}

