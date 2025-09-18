module "service-accounts" {
    source = "git::ssh://git@gitlab.com/basivireddy1212/terraform-apps-lib//service-accounts"
    for_each = {
        for k, v in try(var.service_accounts, {}) : k => v if v.delete != true
    }
    display_name = each.value.display_name
    account_id = each.value.account_id
    project_id = each.value.project_id
}