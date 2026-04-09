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
  visibility = "private"
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  homepage_url = "https://stien.ch/lkt/"
}

resource "github_branch_protection_v3" "lkt-website" {
  repository     = "lkt-website"
  branch         = "main"
  enforce_admins = true

  required_pull_request_reviews  {
    required_approving_review_count = 1
    require_code_owner_reviews = true
    require_last_push_approval = true
    
    bypass_pull_request_allowances {
      users = [ "stiench" ]
    }
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
  visibility = "private"
  squash_merge_commit_title = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
}

resource "github_branch_protection_v3" "terraform" {
  repository     = "terraform"
  branch         = "main"
  enforce_admins = true

  required_status_checks {
    strict   = false
    checks = distinct([
      "Plan"
    ])
  }

  required_pull_request_reviews  {
    required_approving_review_count = 1
    require_code_owner_reviews = true
    bypass_pull_request_allowances {
      users = [ "stiench" ]
    }
  }
}

# Default branch protection
resource "github_branch_protection_v3" "github_branch_protection_v3" {
  for_each = toset([])

  repository     = each.key
  branch         = "main"
  enforce_admins = true

  required_pull_request_reviews  {
    required_approving_review_count = 0
  }
}
