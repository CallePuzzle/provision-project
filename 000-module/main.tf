module "cloudflare" {
  source = "./cloudflare"

  count = var.is_template ? 0 : 1

  name                  = var.name
  cloudflare_account_id = var.cloudflare_account_id
  enable_d1_database    = var.enable_d1_database
}

module "auth0" {
  source = "./auth0"

  count = var.enable_auth0 ? 1 : 0

  name    = var.name
  app_url = var.app_url
}

module "cloudflare_staging" {
  source = "./cloudflare"

  count = var.enable_staging_environment ? 1 : 0

  name                  = "${var.name}-staging"
  cloudflare_account_id = var.staging_cloudflare_account_id
  enable_d1_database    = var.enable_d1_database

  providers = {
    cloudflare = cloudflare.staging
  }
}

module "auth0_staging" {
  source = "./auth0"
  count  = var.enable_staging_environment && var.enable_auth0 ? 1 : 0

  name    = "${var.name}-staging"
  app_url = var.app_url

  providers = {
    auth0 = auth0.staging
  }
}

module "deploy" {
  source = "./deploy"
  count  = var.is_template ? 0 : 1

  repository                         = github_repository.this.name
  app_url                            = var.app_url
  cloudflare_account_id              = var.cloudflare_account_id
  enable_d1_database                 = var.enable_d1_database
  d1_database_id                     = module.cloudflare[0].d1_database_id
  enable_auth0                       = var.enable_auth0
  deploy_worker_cloudflare_api_token = module.cloudflare[0].deploy_worker_cloudflare_api_token
  auth0_client_id                    = module.auth0[0].auth0_client_id
  auth0_client_secret                = module.auth0[0].auth0_client_secret
  extra_secrets                      = var.extra_secrets

  providers = {
    github = github
  }
}