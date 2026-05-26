package main

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_cloudtrail"

  not rc.change.after.is_multi_region_trail
  msg := sprintf("%v must be multi-region (AU-2).", [rc.address])
}

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "aws_cloudtrail"

  not rc.change.after.enable_log_file_validation
  msg := sprintf("%v must enable log file validation (AU-2).", [rc.address])
}
