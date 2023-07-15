module "dns" {
  source = "github.com/vnghia/terraform-modules//modules/cloudflare-dns"

  account_id = var.cloudflare_account_id

  records = { for domain in var.domains : domain =>
    concat(
      [
        {
          name     = "@"
          type     = "MX"
          value    = "mailserver.purelymail.com"
          priority = 50
        },
        {
          name  = "@"
          type  = "TXT"
          value = "v=spf1 include:_spf.purelymail.com ~all"
        },
        {
          name  = "@"
          type  = "TXT"
          value = "purelymail_ownership_proof=${var.purelymail_ownership_code}"
          key   = "purelymail_ownership_proof-${domain}"
        }
      ],
      [
        for i in range(1, 4) : {
          name    = "purelymail${i}._domainkey"
          type    = "CNAME"
          value   = "key${i}.dkimroot.purelymail.com"
          proxied = false
        }
      ],
      [
        {
          name    = "_dmarc"
          type    = "CNAME"
          value   = "dmarcroot.purelymail.com"
          proxied = false
        }
      ]
    )
  }
}
