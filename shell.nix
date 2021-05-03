{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  ruby = pkgs.buildPackages.ruby_2_7;
  env = bundlerEnv {
    name = "jamesmead.org-bundler-env";
    inherit ruby;
    gemdir = ./.;
  };
in mkShell {
  LOCALE_ARCHIVE_2_27 = "${glibcLocales}/lib/locale/locale-archive";
  buildInputs = [ git ruby ];
}
