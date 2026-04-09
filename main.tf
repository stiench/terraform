provider "github" {
  owner = var.github_owner
}

# Retrieve information about the currently (PAT) authenticated user
#data "github_user" "self" {
#  username = ""
#}
