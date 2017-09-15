# Terraform Cloudtrails Bucket

This module creates an S3 bucket suitable for receiving cloudtrail logs from multiple AWS accounts. It implements a configurable log retention policy, which allows you to efficiently manage logs across different storage classes (E.g. glacier) and ultimately expire the data altogether.


## Variables
|  Name                               |  Default            |  Description                                                                            | Required |
|:------------------------------------|:-------------------:|:----------------------------------------------------------------------------------------|:--------:|
| `name`                              | ``                  | Name of the bucket (e.g. `log`)                                                                   | Yes      |
| `accounts`                          | ``                  | List of additional account IDs that should be granted access to send cloudtrail logs (e.g. `111111111111`)                               | No      |
| `namespace`                         | ``                  | Namespace (e.g. `cp` or `cloudposse`)                                                   | Yes      |
| `stage`                             | ``                  | Stage (e.g. `prod`, `dev`, `staging`)                                                   | Yes      |
| `acl`                               | `log-delivery-write`| The canned ACL to apply                                                                 | No       |
| `policy`                            | ``                  | A valid bucket policy JSON document                                                     | No       |
| `prefix`                            | ``                  | Object key prefix identifying one or more objects to which the lifecycle rule applies   | No       |
| `region`                            | ``                  | If specified, the AWS region this bucket should reside in. Defaults to region of callee.| No       |
| `force_destroy`                     | ``                  | All objects will be forcefully deleted from the bucket when bucket destroyed            | No       |
| `lifecycle_rule_enabled`            | `true`              | Enable object lifecycle rules on this bucket                                            | No       |
| `versioning_enabled`                | `false`             | Versioning is a means of keeping multiple variants of an object in the same bucket      | No       |
| `noncurrent_version_transition_days`| `30`                | Number of days to persist in the standard storage tier before moving to the glacier tier| No       |
| `noncurrent_version_expiration_days`| `90`                | Specifies when noncurrent object versions expire                                        | No       |
| `standard_transition_days`          | `30`                | Number of days to persist in the standard storage tier before moving to the glacier tier| No       |
| `glacier_transition_days`           | `60`                | Number of days after which to move the data to the glacier storage tier                 | No       |
| `expiration_days`                   | `90`                | Number of days after which to expunge the objects                                       | No       |
