####################
#AWS Provider settings
####################

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

################################
#S3 Bucket to store tfstate file
################################
terraform {
  backend "s3" {
    bucket = "k22yde-eu-west-bucket"
    key    = "euwest-team3_1.tfstate"
    region = "eu-west-2"
  }
}

################################
# Template user_data
################################
data "template_file" "myuserdata_n" {
  template = "${file("${path.cwd}/nginx.tpl")}"
}



################################
#EC-2 Instances Setup - Nginx
################################

resource "aws_instance" "instance_n" {

  #Copy AMI Image
  ami = "ami-002c706045586bd94"

  #Total instance to create
  count = 1

  #instance type
  instance_type = "t2.micro"

  user_data = data.template_file.myuserdata_n.template


  #instance tags
  tags = {
    Name = "TechBleat-Nginx-Server-${count.index + 1}"
  }

  #create security group
  vpc_security_group_ids = ["${aws_security_group.eu-west-t3-sec-sg.id}"]

  #keyname
  key_name = "LDN_key"
}


################################
# Template user_data
################################
data "template_file" "myuserdata_t" {
  template = "${file("${path.cwd}/tomcat.tpl")}"
}

################################
#EC-2 Instances Setup - Tomcat
################################

resource "aws_instance" "instance_t" {

  #Copy AMI Image
  ami = "ami-002c706045586bd94"

  #Total instance to create
  count = 1

  #instance type
  instance_type = "t2.micro"

  user_data = data.template_file.myuserdata_t.template


  #instance tags
  tags = {
    Name = "TechBleat-Tomcat-Server-${count.index + 1}"
  }

  #create security group
  vpc_security_group_ids = ["${aws_security_group.eu-west-t3-sec-sg.id}"]

  #keyname
  key_name = "LDN_key"
}