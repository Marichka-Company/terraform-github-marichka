data "terraform_remote_state" "repos" {
  backend = "remote"

  config = {
    organization = "mariia-komisar"

    workspaces = {
      name = "terraform_github_marichka_company"
    }
  }
}
