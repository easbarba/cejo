FROM docker.io/debian:latest
MAINTAINER John Doe <john@doe.com>

ARG DEBIAN_FRONTEND=noninteractive

# BASE PACKAGES
ENV BUILD_PACKAGES git curl libssl-dev ca-certificates gnupg2 build-essential procps gcc zlib1g-dev

RUN apt update -qy
RUN apt upgrade -qy
RUN apt install -qy $BUILD_PACKAGES --no-install-recommends
RUN apt clean -qy

# RUBY
RUN git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf"
RUN /bin/bash -lc '. $HOME/.asdf/asdf.sh && asdf update && asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git && asdf install ruby 3.0.0 && asdf global ruby 3.0.0'

# PORT
EXPOSE 3333

# FILES
WORKDIR /usr/local/cejo
COPY . /usr/local/cejo

RUN /bin/bash -lc '. $HOME/.asdf/asdf.sh && bundle install'
RUN /bin/bash -lc 'echo ". $HOME/.asdf/asdf.sh" >> "$HOME/.bashrc"'
RUN /bin/bash -lc 'echo export PATH="$HOME/.asdf/shims"${PATH:+:}$PATH >> "$HOME/.bashrc"'

# RUN
CMD ["bash" "-lc"]
