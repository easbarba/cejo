#!/usr/bin/env bash

set -euo pipefail

# CLEAN UP
rm -rf "$PWD.gems"
rm -rf "$PWD.cache"

# INSTALL
gem install bundler
bundle install
