# infleet-mars-elixir
Elixir API for fleet control: infleet

## Spec

### current spec: 1.2

You can check `api.spec.md` at:
* https://github.com/daviaws/infleet-mars/blob/main/api.spec.md

## Data Model

[1.0](https://app.diagrams.net/?rev=0BxgOLdRDrFk4aGpmTUlmTGlFdS9lMVZuNEdsS3BGL3M4dGR3PQ&chrome=0&nav=1&layers=1&edit=_blank&page=-1#G1mC3ti7MyesuD3f4gqD4PKRRjk3Zdn1OJ)

[Latest](https://app.diagrams.net/#G1mC3ti7MyesuD3f4gqD4PKRRjk3Zdn1OJ)

## Hints

[Derive geo](https://github.com/bryanjos/geo)

## Directives
For main `asdf` directives check: https://github.com/daviaws/infleet-mars/blob/main/README.md
  you can check also `man/asdf.md` for better understanding

## Setup project
Script `./project-setup.sh` must do the local setup over `asdf`

## Run docker
After project setup you can run `docker compose up`
  
  you can hook into the docker instance with `docker compose run -it phoenix /bin/bash`

  you can hook into with `iex -S mix` with full command over elixir contexts

## Run local
After `docker compose up` you can just up the db: `docker compose up -d db`
  and run `mix setup && mix phx.server`

  you can hook into with `iex -S mix`

  warning: if you have conflicts may you need to `sudo rm -rf _build deps` because of docker builds

## Test results
Run `mix run -e "InfleetMarsElixir.Task.exec_sample()"`

`InfleetMarsElixir.Task` has the way to show how the Task.Files work with fixtures.

## Total db cost once project setup:
asdf: mb? (dependencies and plugins)
docker-desktop: 428mb (dependencies)
docker-images: 3GB (docker system df)
database: delta volume (data)
total estimated: 5GB
