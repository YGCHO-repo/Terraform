region = "ap-northeast-2"

prefix = "test"

tags = {
  "CreatedByTerraform" = "True"
  "purpose"            = "Terraform_Test"
  "owner"              = "MSC"
  "purpose"            = "TEST"
  "resource"           = "EC2"
}

add_instance = {
  "bastion" = {
    instance_name     = "bastion"
    availability_zone = "ap-northeast-2a"
    instance_type     = "t2.micro"
    key_name          = "tf_test_key"
    security_groups   = "sg-069727bea0eaed235"
    subnet_id         = "subnet-032c659e8e3442537"
    volume_size       = 8
    volume_type       = "gp2"
    eip               = true
  },
  "web_a" = {
      instance_name     = "web"
      availability_zone = "ap-northeast-2a"
      instance_type     = "t2.micro"
      key_name          = "tf_test_key"
      security_groups   = "sg-04afd6cabdc1f0487"
      subnet_id         = "subnet-01a0f279f6b6d9787"
      volume_size       = 8
      volume_type       = "gp2"
      eip               = false
    },
  "web_c" = {
      instance_name     = "web"
      availability_zone = "ap-northeast-2c"
      instance_type     = "t2.micro"
      key_name          = "tf_test_key"
      security_groups   = "sg-04afd6cabdc1f0487"
      subnet_id         = "subnet-0ba550a7bdb08c13b"
      volume_size       = 8
      volume_type       = "gp2"
      eip               = false
    },
  "was_a" = {
      instance_name     = "was"
      availability_zone = "ap-northeast-2a"
      instance_type     = "t2.micro"
      key_name          = "tf_test_key"
      security_groups   = "sg-0158f0bfb03ae6c43"
      subnet_id         = "subnet-0b27e3fbf77bdb5cd"
      volume_size       = 8
      volume_type       = "gp2"
      eip               = false
    },
  "was_c" = {
      instance_name     = "was"
      availability_zone = "ap-northeast-2c"
      instance_type     = "t2.micro"
      key_name          = "tf_test_key"
      security_groups   = "sg-0158f0bfb03ae6c43"
      subnet_id         = "subnet-0880d6b20ef7d8928"
      volume_size       = 8
      volume_type       = "gp2"
      eip               = false
    },

}