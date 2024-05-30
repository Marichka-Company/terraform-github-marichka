# Notes:
#
# Archived repos require the following things enabled:
# - has_issues
# - has_projects
# - has_wiki
# Apparently, they are enabled upon archiving and cause
# terraform plan drift.

locals {
  repos = {
    airborne = {
      name                    = "airborne"
      description             = "i18"
      branch_protection_rules = [for rule in local.bp_rules.main_and_release_and_version : merge(rule, { latest_strict_check = false })]
    }
    airborne-translations = {
      name                    = "airborne-translations"
      branch_protection_rules = local.bp_rules__no_ci.main_and_release
    }
    airbus = {
      name                    = "airbus"
      branch_protection_rules = local.bp_rules.master
    }
    airflow-infra-dags = {
      name                    = "airflow-infra-dags"
      description             = "DAG storage for https://airflow-infra.bcdtriptechinternal.com/"
      branch_protection_rules = local.bp_rules__no_ci.main
      ops_repo                = true
    }
    airline-logos-scraper = {
      name                    = "airline-logos-scraper"
      branch_protection_rules = local.bp_rules.main
    }
    alexa = {
      name        = "alexa"
      description = "A TripSource Voice / Alexa app written by Mobiquity a few years ago"
    }
    alstom = {
      name                    = "alstom"
      branch_protection_rules = [for rule in local.bp_rules.master : merge(rule, { latest_strict_check = false })]
      vulnerability_alerts    = false
    }
    antonov = {
      name                    = "antonov"
      description             = "Concur adaptor"
      branch_protection_rules = local.bp_rules.main_and_release_and_version
    }
    bcd_infra = {
      name                    = "bcd_infra"
      description             = "Terraform for the shared Infrastructure Account"
      branch_protection_rules = local.bp_rules__tf.bcd_infra
      ops_repo                = true
    }
    sikorsky = {
      name                    = "sikorsky"
      branch_protection_rules = local.bp_rules.master_and_version
      vulnerability_alerts    = false
      ops_repo                = true
    }
    terraform-aws-email-to-s3-lambda = {
      name                    = "terraform-aws-email-to-s3-lambda"
      branch_protection_rules = local.bp_rules.master
      ops_repo                = true
    }
    terraform-aws-provider-inbox-s3-trigger = {
      name                    = "terraform-aws-provider-inbox-s3-trigger"
      description             = "Terraform module that creates an provider-inbox-s3-trigger lambda which triggers ecs spitfire task for parsing lockheed files"
      branch_protection_rules = local.bp_rules__no_ci.main
      ops_repo                = true
    }
    tsh-staging = {
      name                    = "tsh-staging"
      description             = "TSH Staging Account"
      branch_protection_rules = local.bp_rules__tf.tsh_staging
      ops_repo                = true
    }
    tsh-staging-argocd = {
      name                    = "tsh-staging-argocd"
      branch_protection_rules = local.bp_rules__no_ci.main
      ops_repo                = true
    }
    uat-argo-cd = {
      name = "uat-argo-cd"
      branch_protection_rules = [
        {
          name                    = "default"
          pattern                 = "main"
          required_approval_count = 2
        },
      ]
      ops_repo = true
    }
  }

  all_repos_admin = flatten([
    for repo in local.repos : { name : repo.name, permission = "admin" }
    ]
  )

  argocd_staging_repo_push = {
    name : "tsh-staging-argocd",
    permission = "push"
  }
  argocd_uat_repo_push = {
    name : "uat-argo-cd",
    permission = "push"
  }

  # A workaround to speed up Terraform plans.
  # Exclude repositories owned by devops from the list passed to non-ops teams,
  # since they do not need team access to ops repos for code reviews
  # (that is the main purpose of the `github_team_repository` resource).
  # Experience shows developers usually request team reviews solely on dev repos.
  ops_repos = [for repo in local.repos : repo.name if try(repo.ops_repo, false)]

  all_non_ops_repos_push = flatten([
    for repo in local.repos : { name : repo.name, permission = "push" }
    if !contains(local.ops_repos, repo.name)
    ]
  )
}

module "repo" {
  for_each = local.repos

  source                  = "./repository"
  name                    = each.value.name
  description             = try(each.value.description, null)
  private                 = try(each.value.private, false)
  archived                = try(each.value.archived, false)
  autolink_references     = local.autolink_references
  branch_protection_rules = try(each.value.branch_protection_rules, [])
  has_issues              = try(each.value.has_issues, false)
  has_projects            = try(each.value.has_projects, false)
  has_wiki                = try(each.value.has_wiki, false)
  vulnerability_alerts    = try(each.value.vulnerability_alerts, true)
}
