terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

resource "github_team" "team" {
  name           = var.name
  description    = var.description
  privacy        = var.privacy
  parent_team_id = var.parent_team_id
}

resource "github_team_members" "members" {
  count   = length(var.team_members) > 0 ? 1 : 0
  team_id = github_team.team.id

  dynamic "members" {
    for_each = var.team_members
    content {
      username = members.value["name"]
      role     = members.value["role"]
    }
  }
}

resource "github_team_repository" "repo" {
  for_each = { for repo in var.repos : repo.name => repo }
  team_id  = github_team.team.id

  repository = each.key
  permission = each.value["permission"]
}
