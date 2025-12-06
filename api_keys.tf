# This is informational only to show how to create and manage R2 API keys via terraform.
# Please note this requires a solid secrets management approach as you may not want to store secrets in tfstate (they are in plain-text)

# data "cloudflare_api_token_permission_groups_list" "all" {}

# locals {
#   dns_write_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "DNS Write"
#   ])

#   account_rulesets_write_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "Account Rulesets Write"
#   ])

#   r2_storage_write_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "Workers R2 Storage Write"
#   ])

#   r2_storage_read_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "Workers R2 Storage Read"
#   ])

#   r2_bucket_item_write_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "Workers R2 Storage Bucket Item Write"
#   ])

#   r2_bucket_item_read_permission_id = one([
#     for perm in data.cloudflare_api_token_permission_groups_list.all.result :
#     perm.id
#     if perm.name == "Workers R2 Storage Bucket Item Read"
#   ])

#   github_meta    = jsondecode(data.http.github_meta.response_body)
#   github_actions = local.github_meta.actions
# }

# data "http" "github_meta" {
#   url = "https://api.github.com/meta"
#   request_headers = {
#     Accept = "application/json"
#   }
# }


# resource "cloudflare_api_token" "r2_tfstate_backend_key4" {
#   name = "r2-tfstate-backend-key"
#   policies = [{
#     effect = "allow"
#     permission_groups = [
#       { id = local.r2_storage_write_permission_id },
#       { id = local.r2_storage_read_permission_id }
#     ]
#     resources = jsonencode({
#       # Format: com.cloudflare.edge.r2.bucket.<ACCOUNT_ID>_<JURISDICTION>_<BUCKET_NAME>
#       "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_your-bucket-name" = "*"
#     })
#   }
# ]

#   condition = {
#     request_ip = {
#       in = local.github_actions
#     }
#   }
# } 
