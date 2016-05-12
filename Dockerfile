FROM ubuntu

MAINTAINER Mason Fischer <mason@mason.money>

ENV BITCOIN_CONVERSION_RATE=444.18
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install curl locales && \
    locale-gen "en_US.UTF-8" && \
    curl -o /tmp/erlang.deb http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i /tmp/erlang.deb && \
    rm -rf /tmp/erlang.deb && \
    (curl -sL https://deb.nodesource.com/setup_5.x | bash) && \
    apt-get install -y erlang elixir nodejs git build-essential libtool autoconf && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/*

RUN curl -LO https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz && \
    tar -xf libsodium-1.0.10.tar.gz && \
    cd libsodium-1.0.10 && \
    ./configure && \
    make check && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf libsodium-1.0.10

# Add local node module binaries to PATH
ENV PATH ./node_modules/.bin:$PATH

# Install Hex+Rebar
ENV LANG="en_US.UTF-8"
ENV LC_TYPE="en_US.UTF-8"
RUN mix local.hex --force && \
    mix local.rebar --force

# Set exposed ports

# Cache npm deps
ADD package.json package.json
RUN npm install
RUN npm install -g webpack

# Same with elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

ENV PORT=5000 MIX_ENV=prod

RUN webpack --progress -p && \
    mix do compile, phoenix.digest



CMD ["mix", "phoenix.server"]
EXPOSE 5000
