terraform {
  cloud {
    organization = "vnghia"
    hostname     = "app.terraform.io"
    workspaces {
      name = "automation-purelymail-dns-records"
    }
  }
}
