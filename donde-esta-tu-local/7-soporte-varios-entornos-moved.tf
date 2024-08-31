moved {
  from = module.this.auth0_client.this[0]
  to   = module.this.module.auth0[0].auth0_client.this
}

moved {
  from = module.this.auth0_client_credentials.this[0]
  to   = module.this.module.auth0[0].auth0_client_credentials.this
}

moved {
  from = module.this.cloudflare_api_token.deploy_worker[0]
  to   = module.this.module.cloudflare[0].cloudflare_api_token.deploy_worker
}

moved {
  from = module.this.cloudflare_d1_database.this["main"]
  to   = module.this.module.cloudflare[0].cloudflare_d1_database.this
}

moved {
  from = module.this.github_actions_secret.auth0_client_id[0]
  to   = module.this.module.deploy[0].github_actions_secret.auth0_client_id[0]
}

moved {
  from = module.this.github_actions_secret.auth0_client_secret[0]
  to   = module.this.module.deploy[0].github_actions_secret.auth0_client_secret[0]
}

moved {
  from = module.this.github_actions_secret.deploy_worker[0]
  to   = module.this.module.deploy[0].github_actions_secret.deploy_worker
}

moved {
  from = module.this.github_actions_secret.extra["JWK"]
  to   = module.this.module.deploy[0].github_actions_secret.extra["JWK"]
}

moved {
  from = module.this.github_repository_file.workflow_deploy
  to   = module.this.module.deploy[0].github_repository_file.workflow_deploy
}

moved {
  from = module.this.github_repository_file.wrangler_toml
  to   = module.this.module.deploy[0].github_repository_file.wrangler_toml
}

//moved {
//  from = module.this.module.auth0[0]
//  to = module.this.module.auth0_staging[0]
//}
//
//moved {
//  from = module.this.module.cloudflare[0]
//  to = module.this.module.cloudflare_staging[0]
//}

moved {
  from = module.this.module.deploy[0].github_repository_file.workflow_deploy
  to   = module.this.module.deploy[0].github_repository_file.workflow_deploy[0]
}

moved {
  from = module.this.module.deploy[0].github_repository_file.wrangler_toml
  to   = module.this.module.deploy[0].github_repository_file.wrangler_toml[0]
}