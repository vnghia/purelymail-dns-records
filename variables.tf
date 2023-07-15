variable "purelymail_ownership_code" {
  type        = string
  description = "PurelyMail ownership code"
  sensitive   = true
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID"
}

variable "domains" {
  type        = list(string)
  description = "List of custom domains to add to PurelyMail"
}
