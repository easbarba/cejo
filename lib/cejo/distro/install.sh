#!/usr/bin/env bash

set -euo pipefail

# CLEAN UP
rm -rf "$PWD.gems"
rm -rf "$PWD.cache"

# SETUP
gem install bundler --no-document
bin/setup
