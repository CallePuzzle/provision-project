output "env" {
    value = <<EOF
APP_URL=http://localhost:5173
AUTH0_DOMAIN=${local.env.AUTH0_DOMAIN}
AUTH0_CLIENT_ID=${local.env.AUTH0_CLIENT_ID}
AUTH0_CLIENT_SECRET=${local.env.AUTH0_CLIENT_SECRET}
AUTH0_REDIRECT_URI=http://localhost:5173/login/callback
DATABASE_URL="file:./dev.db"
EOF
    sensitive = true
}

output "extra_secrets" {
  value = var.extra_secrets
  sensitive = true
}