#!/usr/bin/env bash

phoenix::start_web_service() {
  mix deps.get &&
  mix ecto.migrations || {
    mix ecto.create \
      && mix ecto.migrate \
      && mix run priv/repo/seeds.exs
  } || {
      echo "Error at pre-running application step."
      exit 1
  }

  exec mix phx.server
}

case "$1" in
  phoenix::start_web_service)
    phoenix::start_web_service
    ;;
  *)
    exec "${@}"
    ;;
esac
