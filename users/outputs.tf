output "members" {
  value = github_membership.regular_membership.*
}

output "admins" {
  value = github_membership.admin_membership.*
}

output "all" {
  value = concat(github_membership.regular_membership.*, github_membership.admin_membership.*)
}