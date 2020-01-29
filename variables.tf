variable "name" {
  description = "Name for the bucket"
  type        = string
}

variable "accounts" {
  description = "List of additional accounts that should be granted cloudtrails access"
  type        = list(string)
  default     = []
}

variable "namespace" {
  type = string
}

variable "stage" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "delimiter" {
  type    = string
  default = "-"
}

variable "attributes" {
  type    = list(string)
  default = []
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  default     = "log-delivery-write"
}

variable "prefix" {
  description = "(Optional) Key prefix. Used to manage object lifecycle events."
  default     = ""
}

variable "region" {
  description = "(Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
  default     = ""
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "lifecycle_rule_enabled" {
  description = "(Optional) enable lifecycle events on this bucket"
  type        = bool
  default     = true
}

variable "versioning_enabled" {
  description = "(Optional) A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket."
  type        = bool
  default     = false
}

variable "noncurrent_version_expiration_days" {
  description = "(Optional) Specifies when noncurrent object versions expire."
  type        = number
  default     = 90
}

variable "noncurrent_version_transition_days" {
  description = "(Optional) Specifies when noncurrent object versions transitions"
  type        = number
  default     = 30
}

variable "standard_transition_days" {
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
  type        = number
  default     = 90
}

variable "glacier_transition_days" {
  description = "Number of days after which to move the data to the glacier storage tier"
  type        = number
  default     = 180
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  type        = number
  default     = 365
}
