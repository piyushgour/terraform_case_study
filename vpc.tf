resource "aws_vpc" "web_vpc" {
  cidr_block = var.cidr_range_for_web_vpc
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name               = "Web_VPC"
    Environment        = "Test"
    Application        = "Web Server"
  }
}

resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    Name               = "Web_VPC"
    Environment        = "Test"
    Application        = "Web Server"
  }
}

resource "aws_route_table" "web_route_table" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }
}



resource "aws_subnet" "web_vpc_subnet" {
    vpc_id = aws_vpc.web_vpc.id
    map_public_ip_on_launch = true
    count = length(var.public_subnet_for_web)
    cidr_block = var.public_subnet_for_web[count.index]
    tags = {
    Name               = "Web_VPC_Subnet-${count.index+1}"
    Environment        = "Test"
    Application        = "Web Server"
  }

}


# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public_route_table_asso" {
  count = "${length(var.public_subnet_for_web)}"
  subnet_id      = "${element(aws_subnet.web_vpc_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.web_route_table.id
}
