# build stage
FROM hexpm/elixir:1.12.3-erlang-24.1.2-alpine-3.14.2 AS build

ARG MIX_ENV="prod"

RUN apk add --no-cache build-base git python3 curl

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV="${MIX_ENV}"

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

RUN mkdir config
COPY config/config.exs config/$MIX_ENV.exs config/

RUN mix deps.compile

COPY priv priv
COPY assets assets
RUN mix assets.deploy

COPY lib lib
RUN mix compile

COPY config/runtime.exs config/
RUN mix release

# app stage
FROM alpine:3.14.2 AS app

ARG MIX_ENV="prod"

RUN apk add --no-cache libstdc++ openssl ncurses-libs

ENV USER="elixir"

WORKDIR "/home/${USER}/app"

# Create  unprivileged user to run the release
RUN \
    addgroup \
    -g 1000 \
    -S "${USER}" \
    && adduser \
    -s /bin/sh \
    -u 1000 \
    -G "${USER}" \
    -h "/home/${USER}" \
    -D "${USER}" \
    && su "${USER}"

# run as user
USER "${USER}"

# copy release executables
COPY --from=build --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/dockview ./

ENTRYPOINT ["bin/dockview"]

CMD ["start"]
