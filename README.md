# Terraform Cloudtrails Bucket

This module creates an S3 bucket suitable for receiving cloudtrail logs from multiple AWS accounts. It implements a configurable log retention policy, which allows you to efficiently manage logs across different storage classes (E.g. glacier) and ultimately expire the data altogether.
