output "all_repos_admin" {
  value = local.all_repos_admin
}

output "argocd_staging_repo_push" {
  value = local.argocd_staging_repo_push
}

output "argocd_uat_repo_push" {
  value = local.argocd_uat_repo_push
}

output "ops_repos" {
  value = local.ops_repos
}

output "all_non_ops_repos_push" {
  value = local.all_non_ops_repos_push
}
