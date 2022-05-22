{
  description = "Vitest Nix Direnv Bug Reproduction";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";

    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        # The default development shell was renamed to `default` as of Nix 2.7
        devShell = devShells.default;

        devShells.default =
          pkgs.mkShell { buildInputs = with pkgs; [ nodejs-16_x nixfmt ]; };
      });
}
