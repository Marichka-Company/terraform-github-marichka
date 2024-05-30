terraform {
  cloud {
    organization = "mariia-komisar"

    workspaces {
      name = "terraform_github_marichka_company_teams"
    }
  }
}

provider "github" {
  owner = "Marichka-Company"
}
