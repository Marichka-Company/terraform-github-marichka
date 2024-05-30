terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

resource "github_repository" "repository" {
  name        = var.name
  description = var.description
  archived    = var.archived
  visibility  = var.private == true ? "private" : "public"

  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge

  delete_branch_on_merge = var.delete_branch_on_merge

  has_downloads = var.has_downloads
  has_projects  = var.has_projects
  has_issues    = var.has_issues
  has_wiki      = var.has_wiki

  merge_commit_message = var.merge_commit_message
  merge_commit_title   = var.merge_commit_title

  squash_merge_commit_message = var.squash_merge_commit_message
  squash_merge_commit_title   = var.squash_merge_commit_title

  vulnerability_alerts = var.vulnerability_alerts
}

resource "github_branch_protection" "branch_protection" {
  for_each = {
    for _, rule in var.branch_protection_rules : rule.name => rule
  }
  repository_id = github_repository.repository.id

  pattern = each.value.pattern

  required_status_checks {
    strict   = each.value.latest_strict_check
    contexts = each.value.contexts
  }

  required_pull_request_reviews {
    require_code_owner_reviews      = true
    required_approving_review_count = each.value.required_approval_count
  }
}

# resource "github_repository_autolink_reference" "autolink" {
#   for_each = var.autolink_references

#   repository          = github_repository.repository.name
#   key_prefix          = each.value
#   target_url_template = "https://getgoing.atlassian.net/browse/${each.value}<num>"
# }
