{
  description = "A Nix-flake-based PHP development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    phps.url = "github:loophp/nix-shell";
  };

  outputs = { self, nixpkgs, utils, phps }:

    utils.lib.eachDefaultSystem (system:
      let
        overlays = [ phps.overlays.default ];
        pkgs = import nixpkgs {
          inherit overlays system;
        };

        php = pkgs.api.buildPhpFromComposer {
          src = self;
          php = pkgs.php; # Change to php56, php70, ..., php81, php82, php83 etc.
        };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            php
            php.packages.composer
          ];

          shellHook = ''
            php --version
          '';
        };
      });
}
