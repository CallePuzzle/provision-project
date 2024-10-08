# Provision Project
Repositorio para crear aplicaciones con [SvelteKit](https://kit.svelte.dev/), desplegados en [Cloudflare Workers](https://workers.cloudflare.com/).

Los servicios de lo que se hacen uso son:
- Cloudflare
- MongoDB Atlas
- Auth0

Todos tienen un plan gratuito que se puede utilizar para este proyecto.

## Requisitos mínimos

- Terraform: Se recomienda usar [tfenv](https://github.com/tfutils/tfenv) para manejar las versiones de Terraform.
- `CLOUDFLARE_API_TOKEN`: Se crea desde la [consola de Cloudflare](https://dash.cloudflare.com/profile/api-tokens). Los permisos necesarios son:
    - All accounts - D1:Edit, Account Settings:Read
    - All users - API Tokens:Edit, Memberships:Read, User Details:Read

![](./docs/image-01.png)

- `GITHUB_TOKEN`: Se crea desde la [configuración de GitHub](https://github.com/settings/tokens)

## No ver cambios en el terraform.tfvars

En el terraform.tfvars van los tokens de auth0 que se renuevan cada 24 horas, por lo que no se deben ver cambios en el repositorio. Para evitar esto, se puede hacer lo siguiente:

```bash
git update-index --assume-unchanged donde-esta-tu-local/terraform.tfvars
```

https://stackoverflow.com/questions/23673174/how-to-ignore-new-changes-to-a-tracked-file-with-git