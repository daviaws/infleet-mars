# infleet-mars-elixir
Elixir API for fleet control: infleet

## Spec

### current spec: 1.2

You can check `api.spec.md` at:
* https://github.com/daviaws/infleet-mars/blob/main/api.spec.md
* https://github.com/daviaws/infleet-mars/blob/elixir/api.spec.md

## Data Model

![Latest](https://app.diagrams.net/#G1mC3ti7MyesuD3f4gqD4PKRRjk3Zdn1OJ)

[1.0 deprecated! please update once stable](https://app.diagrams.net/?rev=0BxgOLdRDrFk4TU5nVWhBWXFWTEF5ZUxTTU5oZ1NGMXRuMXRFPQ&page=-1#G1mC3ti7MyesuD3f4gqD4PKRRjk3Zdn1OJ)

## Hints

[Derive geo](https://github.com/bryanjos/geo)

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
