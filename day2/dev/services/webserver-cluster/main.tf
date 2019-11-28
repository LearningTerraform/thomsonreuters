provider "aws" {
	region = "us-east-1"
}

resource "aws_launch_configuration" "example" {
	image_id = "ami-04763b3055de4860b"
	instance_type = "t2.micro"
	associate_public_ip_address = true
	security_groups = [aws_security_group.my-sec-group.id]
	user_data = data.template_file.user-data.rendered


	lifecycle {
		create_before_destroy = true	
	}
}


data "template_file" "user-data" {
		template = file("user-data.sh")

		vars = {
			db_address = data.terraform_remote_state.db.outputs.address
			db_port = data.terraform_remote_state.db.outputs.port
		}
	}


data "terraform_remote_state" "db" {
		backend = "s3"
		config = {
			bucket = "my-terraform-bucket-npsoni2"
			key = "dev/data-stores/mysql/terraform.tfstate"
			region = "us-east-1"
		}
}


resource "aws_autoscaling_group" "example"{
	launch_configuration = aws_launch_configuration.example.name
	vpc_zone_identifier = data.aws_subnet_ids.default.ids
	min_size = 2
	max_size = 10
	tag {
		key = "Name"
		value = "terraform-asg-example"
		propagate_at_launch = true
	}

}

data "aws_vpc" "default" {
	default = true
}

data "aws_subnet_ids" "default" {
	vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "my-sec-group" {
	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

terraform {
	backend "s3" {
		bucket = "my-terraform-bucket-npsoni2"
		key = "dev/services/webserver-cluster/terraform.tfstate"
		region = "us-east-1"

		#dynamo db locking
		dynamodb_table = "tf-state-locks"
		encrypt = true
	}
}