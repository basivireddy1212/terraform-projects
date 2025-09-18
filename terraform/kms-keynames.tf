#in GCP, Key Rings (KMS KeyRings) cannot be deleted once created.
module "kmskeynames" {
  source = "git::https://github.com/basivireddy1212/terraform-lib//terraform-modules/kms-keynames?ref=main"
  # for local testing
  # source = "../../terraform-modules/kms-keynames"
  for_each     = var.keynames
  kms_key_name = each.value.kms_key_name
  key_ring     = each.value.key_ring

  #depends_on = [module.kmskeyrings]
}