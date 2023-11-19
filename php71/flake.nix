{
  description = "A Nix-flake-based PHP 7.1 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    phps.url = "github:fossar/nix-phps";
  };

  outputs = { self, nixpkgs, utils, phps }:

    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = [
            phps.packages.${system}.php71
            phps.packages.${system}.php71.packages.composer
          ];
        };
      });
}
