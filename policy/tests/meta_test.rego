package main
import data.main.deny

test_missing_required_tags_fails {
  input = {
    "resource_changes": [
      {
        "address": "aws_s3_bucket.logs",
        "change": {
          "after": {
            "tags": {
              "Owner": "TeamA"
            }
          }
        }
      }
    ]
  }

  results := deny with input as input
  count(results) == 1
}

test_all_required_tags_pass {
  input = {
    "resource_changes": [
      {
        "address": "aws_s3_bucket.logs",
        "change": {
          "after": {
            "tags": {
              "Owner": "TeamA",
              "Environment": "dev",
              "ManagedBy": "Terraform"
            }
          }
        }
      }
    ]
  }

  results := deny with input as input
  count(results) == 0
}
