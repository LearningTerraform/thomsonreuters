provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
	bucket = "my-terraform-bucket-npsoni2"

	# precent accidental destruction
	lifecycle {
		prevent_destroy = true
	}

	# enable versoning of the terraform state files for disaster recovery
	versioning {
		enabled = true
	}

	server_side_encryption_configuration {
		rule {
			apply_server_side_encryption_by_default {
				sse_algorithm = "AES256"
			}
		}
	}

}

resource "aws_dynamodb_table" "my-tf-locks" {
	name = "tf-state-locks"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"

	attribute {
		name ="LockID"
		type ="S"
	}
}


terraform {
	backend "s3" {
		bucket = "my-terraform-bucket-npsoni2"
		key = "global/s3/terraform.tfstate"
		region = "us-east-1"

		#dynamo db locking
		dynamodb_table = "tf-state-locks"
		encrypt = true
	}
}