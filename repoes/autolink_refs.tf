locals {
  autolink_prefixes = [
    "ASBC2024",
    "AUT",
    "CM",
    "DES",
    "GG",
    "OBT",
    "OPS",
    "RAIL",
    "SUP",
    "TFAPP",
  ]

  autolink_references = toset(formatlist("%s-", local.autolink_prefixes))
}
