FROM docker.io/debian:latest
WORKDIR /usr/local/cejo
COPY . /usr/local/cejo

# PORT
EXPOSE 3333

# BASE PACKAGES
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && \
    apt-get install -qy git procps curl ca-certificates gnupg2 build-essential --no-install-recommends \
    && apt-get clean

# RUBY
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.7.2 && bundle install"

# RUN
CMD ["exe/cejo"]
