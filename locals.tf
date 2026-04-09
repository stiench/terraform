# Create local values to retrieve items from CSVs
locals {
  # Parse team member files
  team_members_path = "team-members"
  team_members_files = var.manage_organization_resources ? {
    for file in fileset(local.team_members_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.team_members_path}/${file}"))
  } : {}
  # Create temp object that has team ID and CSV contents
  team_members_temp = var.manage_organization_resources ? flatten([
    for team, members in local.team_members_files : [
      for tn, t in github_team.all : {
        name    = t.name
        id      = t.id
        slug    = t.slug
        members = members
      } if t.slug == team
    ]
  ]) : []

  # Create object for each team-user relationship
  team_members = var.manage_organization_resources ? flatten([
    for team in local.team_members_temp : [
      for member in team.members : {
        name     = "${team.slug}-${member.username}"
        team_id  = team.id
        username = member.username
        role     = member.role
      }
    ]
  ]) : []

  # Parse repo team membership files
  repo_teams_path = "repos-team"
  repo_teams_files = var.manage_organization_resources ? {
    for file in fileset(local.repo_teams_path, "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("${local.repo_teams_path}/${file}"))
  } : {}

  # Name of the default permissions file
  repos_team_default = "default"

  #Load repos
  repos = [ for repo in csvdecode(file("repos.csv")) : repo ]

  # Permission for each team per repos
  repos_team_permissions = var.manage_organization_resources ? merge([
    for repo in local.repos : {
      for team in local.repo_teams_files[contains(keys(local.repo_teams_files), repo.name) ? repo.name : local.repos_team_default]: 
        "${repo.name}_${team.team_name}" => {
        team_id = github_team.all[team.team_name].id
        repo_name = repo.name
        permission = team.permission
      } if lookup(github_team.all, team.team_name, false) != false
    }
  ]...) : {}
}
