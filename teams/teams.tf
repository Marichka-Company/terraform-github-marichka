
locals {
  epam_members = {
    marichka = { name = "KomissarMaria", role = "member" }
  }
  ops_members = {
    marichka-komisar = { name = "marichka-komisar", role = "maintainer" }
    markomisar       = { name = "MaryAlexKom", role = "maintainer" }
    mariika-komisar = { name = "mariika-komisar", role = "member"}
  }
  qa_members = {
    marichka-komisar  = { name = "marichka-komisar", role = "member" }
    mariiakomisar1985 = { name = "mariiakomisar1985", role = "member" }
  }
  support_members = {
    marichka-komisar  = { name = "marichka-komisar", role = "maintainer" }
    mariiakomisar1985 = { name = "mariiakomisar1985", role = "maintainer" }
    mariika-komisar = { name = "mariika-komisar", role = "member"}
  }
  zulu_members = {
    marichka-komisar  = { name = "marichka-komisar", role = "maintainer" }
    mariiakomisar1985 = { name = "mariiakomisar1985", role = "maintainer" }
  }
  whiskey_members = {
      marichka = { name = "KomissarMaria", role = "member" }
  } 

  teams = {
    epam = { name : "epam_contractors",
      description : "EPAM contractors (CM-5862, CM-5876)"
      team_members : local.epam_members,
      repos = data.terraform_remote_state.repos.outputs.all_non_ops_repos_push
    }
    ops = { name : "ops",
      description : "DevOps team members with Admin roles",
      team_members : local.ops_members,
      repos = data.terraform_remote_state.repos.outputs.all_repos_admin
    }
    qa = { name : "qa",
      description : "Quality Assurance",
      team_members : local.qa_members,
      repos = data.terraform_remote_state.repos.outputs.all_non_ops_repos_push
    }
    # support = { name : "support", # TODO: Check permissions for this team
    #   team_members : local.support_members,
    #   repos = local.all_non_ops_repos_push
    # }
    zulu = { name : "zulu",
      description : "Zulu BE team",
      team_members : local.zulu_members
      repos = data.terraform_remote_state.repos.outputs.all_non_ops_repos_push
    }
    whiskey = { name : "whiskey",
      description : "Support team",
      team_members : local.whiskey_members,
      parent_team_id = module.support.team_id
      repos = data.terraform_remote_state.repos.outputs.all_non_ops_repos_push
    }
  }
}

module "team" {
  for_each = local.teams

  source         = "./teams"
  name           = each.value.name
  description    = try(each.value.description, null)
  team_members   = each.value.team_members
  parent_team_id = try(each.value.parent_team_id, null)
  repos          = try(each.value.repos, [])
}

#Used as separate team, because parent team cannot be looped in for_each
module "support" {
  source       = "./teams"
  name         = "support"
  team_members = local.support_members
  repos = data.terraform_remote_state.repos.outputs.all_non_ops_repos_push
}
