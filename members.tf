resource "github_membership" "all" {
  for_each = var.manage_organization_resources ? {
    for member in csvdecode(file("members.csv")) :
    member.username => member
  } : {}

  username = each.value.username
  role     = each.value.role
}