FROM elixir:1.14.2

RUN mix local.hex --force \
  && mix archive.install --force hex phx_new 1.6.15 \
  && apt-get update \
  && apt-get install -y apt-utils \
  && apt-get install -y build-essential \
  && apt-get install -y inotify-tools \
  && mix local.rebar --force

COPY . /app
WORKDIR /app

RUN mix deps.get

ENTRYPOINT [ "scripts/entrypoint.sh" ]

EXPOSE 4000

CMD ["phoenix::start_web_service"]
