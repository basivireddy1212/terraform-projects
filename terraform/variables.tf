variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zones" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "region_disks" {
  default = {}
}

variable "buckets" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "organization_labels" {
  type = object({
    purpose = string
  })
}

variable "service_accounts" {
  type = any

}

variable "keyrings" {
  type = map(object({
    kms_key_ring_name = string
    location          = string
    project_id        = string
    default           = bool
  }))

}

variable "keynames" {
  type = map(object({
    kms_key_name = string
    key_ring     = string
  }))

}


variable "bucket_iam_member" {
  type = any
}
