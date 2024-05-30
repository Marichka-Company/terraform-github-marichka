locals {
  regular_users = [
    "mariika-komisar",
  ]
  admin_users = [
    "marichka-komisar",
    "MaryAlexKom",
    "mariiakomisar1985"
  ]
  outside_collaborators = [
    "KomissarMaria",
  ]
}

resource "github_membership" "regular_membership" {
  for_each = toset(local.regular_users)
  username = each.key
  role     = "member"
}

resource "github_membership" "admin_membership" {
  for_each = toset(local.admin_users)
  username = each.key
  role     = "admin"
}

# # TODO make dynamic if more than 1 use case
# resource "github_repository_collaborator" "epam_sikorsky" {
#   for_each   = toset(local.outside_collaborators)
#   repository = module.repo["sikorsky"].repository.name
#   username   = each.key
#   permission = "pull"
# }