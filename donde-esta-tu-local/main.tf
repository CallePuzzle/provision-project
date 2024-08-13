terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "donde-esta-tu-local"
    }
  }
}

module "this" {
  source = "../000-module"

  name         = "donde-esta-tu-local"
  app_url      = "https://donde-esta-tu-local.callepuzzle-rkjp.workers.dev"
  description  = "Aplicación para saber donde están las peñas de tu pueblo"
  has_projects = true

  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
  enable_d1_database    = true
  enable_auth0          = true

  extra_secrets = {
    JWK = "{\"alg\": \"ES256\", \"crv\": \"P-256\", \"d\": \"ns9nQBcviqRYoBJHl-AF4eLzaYUNcvQR-4C4P4gYiqw\", \"ext\": true, \"key_ops\": [\"sign\"], \"kty\": \"EC\", \"x\": \"T0WQ9K9-YHGa3vKJrmNnc0WY_8XYBUpP7WfY67g9NSE\", \"y\": \"DB7Wrhu9BJezcKnrOIxcJMq1C2DQcAnbTb-0nFJH2yQ\"}"
  }
}
