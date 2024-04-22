terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.48"
    }
  }
}

provider "azuread" {
  tenant_id     = "12345"
  client_id     = "12345"
  client_secret = "vtS8Q~UmzCbbwTDFnvbFTYMVv6CtV4M~2.veedBv"
}

data "azuread_client_config" "me" {

}

resource "azuread_application" "GithubLeak" {
  display_name = "GithubLeak-Test"
  tags = [
    "HideApp",
    "WindowsAzureActiveDirectoryIntegratedApp",
  ]
}

resource "azuread_service_principal" "GithubLeak" {
  client_id       = azuread_application.GithubLeak.client_id
  account_enabled = false
}

resource "azuread_application_password" "GithubLeak" {
  application_id = azuread_application.GithubLeak.id
}

output "tenant_id" {
  value = data.azuread_client_config.me.tenant_id
}
output "client_id" {
  value = azuread_application.GithubLeak.client_id
}
output "secret" {
  value     = azuread_application_password.GithubLeak.value
  sensitive = true
}
