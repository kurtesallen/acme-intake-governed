package main

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket_server_side_encryption_configuration"

  rule_entry := rc.change.after.rule[_]
  sse_entry := rule_entry.apply_server_side_encryption_by_default[_]

  not sse_entry.sse_algorithm == "aws:kms"

  msg := sprintf("Bucket %v must use aws:kms SSE (SC-13).", [rc.address])
}

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_kms_key"

  not rc.change.after.enable_key_rotation

  msg := sprintf("KMS key %v must have rotation enabled (SC-13).", [rc.address])
}
