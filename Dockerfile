FROM docker.io/debian:unstable
MAINTAINER EAS Barbosa <easbarbosa@tutanota.com>

# PORT
EXPOSE 3333

# WORKING DIRECTORY
WORKDIR /usr/local/cejo

# BASE PACKAGES
ARG DEBIAN_FRONTEND=noninteractive
ENV BUILD_PACKAGES it bash ca-certificates gnupg2 wget autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

RUN apt-get update -qy
RUN apt-get upgrade -qy
RUN apt-get install -qy $BUILD_PACKAGES --no-install-recommends
RUN apt-get clean -qy

# RUBY BINARY
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf
RUN bash -lc '. /root/.asdf/asdf.sh && asdf update'
RUN bash -lc '. /root/.asdf/asdf.sh && asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git'
RUN bash -lc '. /root/.asdf/asdf.sh && asdf install ruby 3.0.0 && asdf global ruby 3.0.0'

# HOME
RUN bash -lc 'echo ". /root/.asdf/asdf.sh" >> "/root/.bashrc"'
RUN bash -lc 'echo export PATH="/root/.asdf/shims"${PATH:+:}$PATH >> "/root/.bashrc"'

# PROJECT
RUN git clone --depth 1 --branch main https://git.sr.ht/~easbarbosa/cejo /usr/local/cejo
RUN mkdir -p /root/.config
RUN cp -R /usr/local/cejo/example/cejo /root/.config/

# INSTALL
RUN bash -lc '. /root/.asdf/asdf.sh && bundle install'
RUN bash -lc '. /root/.asdf/asdf.sh && rake install'

# RUN
ENTRYPOINT ["bash", "-l", "-c"]
