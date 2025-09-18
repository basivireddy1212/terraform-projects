module "bucket_iam_member" {
  source = "./modules/bucket-iam-member"
  for_each = {
        for k, v in try(var.bucket_iam_member, {}) : k => v if v.delete != true
  }
    #source = "../../terraform-modules/kms-keyrings"
    #for_each = var.keyrings
    bucket_name = each.value.bucket_name
    role = each.value.role
    member = each.value.member  
}