variable "name" {}

variable "description" {
  default = ""
}

variable "archived" {
  default = false
}

variable "private" {
  default = false
}

variable "allow_merge_commit" {
  default = true
}

variable "allow_squash_merge" {
  default = true
}

variable "allow_rebase_merge" {
  default = true
}

variable "delete_branch_on_merge" {
  default = true
}

variable "has_downloads" {
  default = false
}

variable "has_projects" {
  default = false
}

variable "has_issues" {
  default = false
}

variable "has_wiki" {
  default = false
}

variable "merge_commit_message" {
  default = "PR_BODY"
}

variable "merge_commit_title" {
  default = "PR_TITLE"
}

variable "squash_merge_commit_message" {
  default = "PR_BODY"
}

variable "squash_merge_commit_title" {
  default = "PR_TITLE"
}

variable "vulnerability_alerts" {
  default = true
}

variable "autolink_references" {
  default = []
  type    = set(string)
}

variable "branch_protection_rules" {
  default = []
  type = list(object({
    name                    = string
    pattern                 = string
    contexts                = optional(list(string), [])
    latest_strict_check     = optional(bool, true)
    required_approval_count = optional(number, 1)
  }))

  description = <<DESC
List of branch protection rule objects.
Later converted to map for use with for_each.
Example:
[
  {
    name    = "default"
    pattern = "master"
    contexts = [
      "continuous-integration/drone/pr",
    ]
    latest_strict_check     = true
    required_approval_count = 1
  },
  {
    name    = "version"
    pattern = "v*.*"
    contexts = [
      "continuous-integration/drone/pr",
    ]
    latest_strict_check     = true
    required_approval_count = 1
  }
]
DESC
}
