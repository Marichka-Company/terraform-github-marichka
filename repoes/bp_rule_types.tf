# Branch protection rule types
#
# Categories:
# - bp_rules        : Rules for main/master/release*/v*.* branches with PR Drone CI context
# - bp_rules__no_ci : Same as above but without contexts
# - bp_rules__tf    : Rules for main/master branches with Terraform Cloud contexts
#
# Types based on branch patterns:
# - main                           : main pattern
# - main_and_release               : main/release* patterns
# - main_and_release_and_version   : main/release*/v*.* patterns
# - main_and_version               : main/v*.* patterns
# - master                         : master pattern
# - master_and_release             : master/release* patterns
# - master_and_release_and_version : master/release*/v*.* patterns
# - master_and_version             : master/v*.* patterns

locals {
  pr_context = "continuous-integration/drone/pr"

  bp_rules = {
    main = [
      { name = "default", pattern = "main", contexts = [local.pr_context] },
    ]
    # Temporary rule for repos which old release.x.xx branches
    # are still deployed to some environment.
    # TODO: assign "main_and_version" afterwards
    main_and_release_and_version = [
      { name = "default", pattern = "main", contexts = [local.pr_context] },
      { name = "release", pattern = "release*", contexts = [local.pr_context] },
      { name = "version", pattern = "v*.*", contexts = [local.pr_context] },
    ]
    main_and_version = [
      { name = "default", pattern = "main", contexts = [local.pr_context] },
      { name = "version", pattern = "v*.*", contexts = [local.pr_context] },
    ]
    master = [
      { name = "default", pattern = "master", contexts = [local.pr_context] },
    ]
    # Temporary rule for repos which old release.x.xx branches
    # are still deployed to some environment.
    # TODO: assign "master_and_version" afterwards
    master_and_release_and_version = [
      { name = "default", pattern = "master", contexts = [local.pr_context] },
      { name = "release", pattern = "release*", contexts = [local.pr_context] },
      { name = "version", pattern = "v*.*", contexts = [local.pr_context] },
    ]
    master_and_version = [
      { name = "default", pattern = "master", contexts = [local.pr_context] },
      { name = "version", pattern = "v*.*", contexts = [local.pr_context] },
    ]
  }

  bp_rules__no_ci = {
    main = [
      { name = "default", pattern = "main" },
    ]
    main_and_release = [
      { name = "default", pattern = "main" },
      { name = "release", pattern = "release*" },
    ]
    main_and_version = [
      { name = "default", pattern = "main" },
      { name = "version", pattern = "v*.*" },
    ]
    master = [
      { name = "default", pattern = "master" },
    ]
    master_and_version = [
      { name = "default", pattern = "master" },
      { name = "version", pattern = "v*.*" },
    ]
  }

  bp_rules__tf = {
    bcd_audit = [
      { name = "default", pattern = "master", contexts = ["Terraform Cloud/mariia-komisar/mko-terraform"] },
    ]
    bcd_data = [
      {
        name    = "default",
        pattern = "master",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-lambda-terraform",
          "Terraform Cloud/mariia-komisar/mko-s3-terraform"
        ]
      },
    ]
    bcd_infra = [
      {
        name    = "default",
        pattern = "main",
        contexts = [
          "Terraform Cloud/mariia-komisar/learn-terraform-move"
        ]
      },
    ]
    bcd_users = [
      {
        name    = "default",
        pattern = "master",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-terraform"
        ]
      },
    ]
    cloudflare = [
      {
        name    = "default",
        pattern = "master",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-lambda-terraform",
          "Terraform Cloud/mariia-komisar/mko-s3-terraform",
        ]
      },
    ]
    datadog = [
      {
        name    = "default",
        pattern = "main",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-lambda-terraform",
          "Terraform Cloud/mariia-komisar/mko-s3-terraform",
        ]
      },
    ]
    gaylord = [
      {
        name    = "default",
        pattern = "master",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-lambda-terraform",
          "Terraform Cloud/mariia-komisar/mko-s3-terraform",
          "Terraform Cloud/mariia-komisar/mko-terraform",
        ]
      },
    ]
    github_getgoing = [
      { name = "default", pattern = "main", contexts = ["Terraform Cloud/mariia-komisar/terraform_github"] },
    ]
    pagerduty = [
      { name = "default", pattern = "master", contexts = ["Terraform Cloud/mariia-komisar/mko-lambda-terraform"] },
    ]
    tfe = [
      { name = "default", pattern = "main", contexts = ["Terraform Cloud/mariia-komisar/mko-s3-terraform"] },
    ]
    tsh_staging = [
      {
        name    = "default",
        pattern = "master",
        contexts = [
          "Terraform Cloud/mariia-komisar/mko-lambda-terraform",
          "Terraform Cloud/mariia-komisar/mko-s3-terraform",
        ]
      },
    ]
  }
}
