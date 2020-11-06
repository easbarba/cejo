#!/usr/bin/env bash

set -e

# * Boostrap

check-deps(){
    deps=(git bash)
}

asdf-get(){
    local asdf_dir="$HOME/.asdf"

    if [[ ! -d $asdf_dir ]]; then
	git clone https://github.com/asdf-vm/asdf.git "$asdf_dir"

	cd "$asdf_dir" && git checkout "$(git describe --abbrev=0 --tags)"
    fi
}

asdf-activate(){
    source "$HOME"/.asdf/completions/asdf.bash
    source "$HOME"/.asdf/asdf.sh

    local asdf_shims_dir="$HOME"/.asdf/shims
    [[ -d $asdf_shims_dir ]] && return

    export PATH="$asdf_shims_dir"${PATH:+:}$PATH
}

e-asdf()
{
    # https://asdf-vm.com/#/core-manage-asdf
    # https://asdf-vm.com/#/core-manage-plugins
    # https://asdf-vm.com/#/core-commands
    # https://asdf-vm.com/#/plugins-all

    e-asdf-install
    e-asdf-activate

    asdf update
}

asdf-ruby()
{
    # https://github.com/asdf-vm/asdf-ruby

    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

    asdf install ruby latest

    asdf global ruby "$(asdf latest ruby)"
}

bundle install
bundle exec rake install
