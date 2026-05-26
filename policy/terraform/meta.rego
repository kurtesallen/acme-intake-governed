package main

required_tags := {"Owner", "Environment", "ManagedBy"}

deny[msg] {
  rc := input.resource_changes[_]

  tags := rc.change.after.tags
  tags != null

  required_tags[k]
  not tags[k]

  msg := sprintf("Resource %v missing required tag: %v.", [rc.address, k])
}
