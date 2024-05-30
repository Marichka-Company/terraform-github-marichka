terraform {
  cloud {
    organization = "mariia-komisar"

    workspaces {
      name = "terraform_github_marichka_company_users"
    }
  }
}

provider "github" {
  owner = "Marichka-Company"
}
