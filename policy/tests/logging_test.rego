package main
import data.main.deny

test_cloudtrail_not_multi_region_fails {
  input = {
    "resource_changes": [
      {
        "address": "aws_cloudtrail.example",
        "type": "aws_cloudtrail",
        "change": {
          "after": {
            "is_multi_region_trail": false
          }
        }
      }
    ]
  }

  results := deny with input as input

  count(results) == 1
}

test_cloudtrail_multi_region_passes {
  input = {
    "resource_changes": [
      {
        "address": "aws_cloudtrail.example",
        "type": "aws_cloudtrail",
        "change": {
          "after": {
            "is_multi_region_trail": true
          }
        }
      }
    ]
  }

  results := deny with input as input

  count(results) == 0
}
