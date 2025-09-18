#output "test1-service_accounts-name" {
#  value = module.service-accounts
#  module.service_accounts["test1"].name
#}

#output "test2-service_accounts-name" {
#  value = module.service-accounts
#}

#output "keyrings" {
#    value = { for k, v in module.kmskeyring : k => v.kms_key_ring_id }
#  value = module.kmskeyrings
#}

output "keynames" {
  #    value = { for k, v in module.kmskeynames : k => v.kms_key_name }
  value = module.kmskeynames
}