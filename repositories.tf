# lkt-website
resource "github_repository" "lkt-website" {
  name = "lkt-website"
  description = "lkt website"
  allow_merge_commit = false
  allow_auto_merge = true
  delete_branch_on_merge = true
  vulnerability_alerts = true
  has_wiki = true
  has_projects = true
  has_issues = true
  visibility = "public"
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  homepage_url = "https://stien.ch/lkt/"
}

resource "github_branch_protection" "lkt-website" {
  repository_id  = github_repository.lkt-website.name
  pattern        = "main"
  enforce_admins = false

  required_pull_request_reviews {
    required_approving_review_count = 1
    require_code_owner_reviews      = true
    require_last_push_approval      = true
  }
}

# Terraform
resource "github_repository" "terraform" {
  name = "terraform"
  description = "Manage GitHub Users, Teams, and Repository Permissions"
  allow_merge_commit = false
  allow_auto_merge = true
  delete_branch_on_merge = true
  vulnerability_alerts = true
  has_wiki = false
  has_projects = false
  has_issues = true
  visibility = "public"
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
}

resource "github_branch_protection" "terraform" {
  repository_id  = github_repository.terraform.name
  pattern        = "main"
  enforce_admins = false

  required_status_checks {
    strict   = false
    contexts = distinct([
      "Plan"
    ])
  }

  required_pull_request_reviews {
    required_approving_review_count = 1
    require_code_owner_reviews      = true
  }
}

# Default branch protection
resource "github_branch_protection" "github_branch_protection" {
  for_each = toset([])

  repository_id  = each.key
  pattern        = "main"
  enforce_admins = false

  required_pull_request_reviews {
    required_approving_review_count = 0
  }
}
