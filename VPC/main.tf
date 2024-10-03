resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      name = "main"
    }
  
}
resource "aws_subnet" "pu_sb" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags ={
        name = "pu-sb"
    }

}
resource"aws_internet_gateway" "ig"{
    vpc_id = aws_vpc.main.id
    tags ={
        name = "ig"
    }

}
resource "aws_route_table" "pu_ro"{
    vpc_id = aws_vpc.main.id
    route{
        gateway_id = aws_internet_gateway.ig.id
        cidr_block = "0.0.0.0/0"
       
    }
    tags = {
            name = "pu_ro"
        }

}
resource "aws_route_table_association" "pu-sb-ro-asso"{
    subnet_id = aws_subnet.pu_sb.id
    route_table_id = aws_route_table.pu_ro.id
}
resource "aws_subnet" "pr_sb" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags ={
        name = "pr-sb"
    }

}
resource "aws_eip" "ip"{
    domain = "vpc"
}
resource "aws_nat_gateway" "nagw"{
    allocation_id = aws_eip.ip.id
    subnet_id = aws_subnet.pr_sb.id
    tags ={
        name = "nagw"
    }
}
resource "aws_route_table" "pr_ro"{
    vpc_id = aws_vpc.main.id
    route{
        gateway_id = aws_nat_gateway.nagw.id
        cidr_block = "0.0.0.0/0"
    }
     tags ={
            name = "pr_ro"
        }

}
resource "aws_route_table_association" "pu_sb_ro_asso"{
    subnet_id = aws_subnet.pr_sb.id
    route_table_id = aws_route_table.pr_ro.id
}
resource "aws_security_group" "sg"{
    vpc_id = aws_vpc.main.id
    name = "sg"
    description = "allow TLS inbound traffic and all outbound traffic"
     tags ={
            name = "sg"
        }

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1" 
        cidr_blocks = ["0.0.0.0/0"]  
    }


}
