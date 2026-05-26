package main

import data.main.deny

test_s3_sse_fails {
  input := {
    "resource_changes": [
      {
        "address": "module.baseline.aws_s3_bucket_server_side_encryption_configuration.logs",
        "type": "aws_s3_bucket_server_side_encryption_configuration",
        "change": {
          "after": {
            "rule": [
              {
                "apply_server_side_encryption_by_default": [
                  {"sse_algorithm": "AES256"}
                ]
              }
            ]
          }
        }
      }
    ]
  }

  results := deny with input as input
  count(results) == 1
}

test_s3_sse_passes {
  input := {
    "resource_changes": [
      {
        "address": "module.baseline.aws_s3_bucket_server_side_encryption_configuration.logs",
        "type": "aws_s3_bucket_server_side_encryption_configuration",
        "change": {
          "after": {
            "rule": [
              {
                "apply_server_side_encryption_by_default": [
                  {"sse_algorithm": "aws:kms"}
                ]
              }
            ]
          }
        }
      }
    ]
  }

  results := deny with input as input
  count(results) == 0
}
