# infleet-mars-elixir
Elixir API for fleet control: infleet

## Spec

### current spec: 1.2

You can check `api.spec.md` at:
* https://github.com/daviaws/infleet-mars/blob/main/api.spec.md
* https://github.com/daviaws/infleet-mars/blob/elixir/api.spec.md

## Directives
For main `asdf` directives check: https://github.com/daviaws/infleet-mars/blob/main/README.md
  you can check also `man/asdf.md` for better understanding

## Setup project
Script `./project-setup.sh` must do the local setup over `asdf`

## Run docker
After project setup you can run `docker-compose up`

## Run local
After `docker-compose up` you can just up the db: `docker compose up -d db`
  and run `mix phx.server`

## Total db cost once project setup:
asdf: mb? (dependencies and plugins)
docker-desktop: 428mb (dependencies)
docker-images: 3GB (docker system df)
database: delta volume (data)
total estimated: 5GB
