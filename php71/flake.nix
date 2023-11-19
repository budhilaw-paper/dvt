{
  description = "A Nix-flake-based PHP 7.2 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    phps.url = "github:loophp/nix-shell";
  };

  outputs = { self, nixpkgs, phps, utils }:

    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            inputs.phps.overlays.default
          ];
        };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            pkgs.env-php71
          ];

          shellHook = ''
            php -v
          '';
        };
      });
}
