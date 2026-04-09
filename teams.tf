resource "github_team" "all" {
  for_each = var.manage_organization_resources ? {
    for team in csvdecode(file("teams.csv")) :
    team.name => team
  } : {}

  name        = each.value.name
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team_membership" "members" {
  for_each = var.manage_organization_resources ? { for tm in local.team_members : tm.name => tm } : {}

  team_id  = each.value.team_id
  username = each.value.username
  role     = each.value.role
}
