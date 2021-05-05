{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  ruby = ruby_2_7;
  packages = [ git ruby libyaml bundler rake rubyPackages.rspec solargraph ];
  locale = "${glibcLocales}/lib/locale/locale-archive";
  commands = ''
  export GEM_HOME=$PWD/.nix-gems
  export GEM_PATH=$GEM_HOME
  export PATH=$GEM_HOME/bin:$PATH
  export PATH=$PWD/bin:$PATH

  bundle install
  rake install --trace
  '';
  shellHooks = commands;

in mkShell {
  LOCALE_ARCHIVE_2_27 = locale;
  buildInputs = packages;
  shellHook = shellHooks;
}
