FROM docker.io/debian:unstable
MAINTAINER EAS Barbosa <easbarbosa@tutanota.com>

# PORT
EXPOSE 3333

ARG DEBIAN_FRONTEND=noninteractive

# BASE PACKAGES
ENV BUILD_PACKAGES git curl libssl-dev ca-certificates gnupg2 build-essential procps gcc zlib1g-dev

RUN apt update -qy
RUN apt upgrade -qy
RUN apt install -qy $BUILD_PACKAGES --no-install-recommends
RUN apt clean -qy

# RUBY
RUN git clone https://github.com/asdf-vm/asdf.git "/root/.asdf"
RUN /bin/bash -lc '. /root/.asdf/asdf.sh && asdf update'
RUN /bin/bash -lc '. /root/.asdf/asdf.sh && asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git'
RUN /bin/bash -lc '. /root/.asdf/asdf.sh && asdf install ruby 3.0.0 && asdf global ruby 3.0.0'

# HOME
RUN /bin/bash -lc 'echo ". /root/.asdf/asdf.sh" >> "/root/.bashrc"'
RUN /bin/bash -lc 'echo export PATH="/root/.asdf/shims"${PATH:+:}$PATH >> "/root/.bashrc"'

# FILES
WORKDIR /usr/local/cejo
COPY . /usr/local/cejo
RUN mkdir -p /root/.config
RUN cp -R ./example/cejo /root/.config/

# INSTALL
RUN /bin/bash -lc '. /root/.asdf/asdf.sh && bundle install'
RUN /bin/bash -lc '. /root/.asdf/asdf.sh && rake install'

# RUN
ENTRYPOINT ["bash", "-l", "-c"]
