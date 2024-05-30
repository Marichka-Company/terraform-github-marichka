variable "name" {}

variable "description" {
  default = ""
}
variable "privacy" {
  default = "closed"
}
variable "team_members" {
  type    = map(any)
  default = {}
}

variable "parent_team_id" {
  default = null
}

variable "repos" {
  type    = list(any)
  default = []
}
