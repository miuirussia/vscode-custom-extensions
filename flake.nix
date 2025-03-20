{
  description = "VSCode Extensions";

  inputs = {
    nixpkgs.url = "github:miuirussia/nixpkgs/nixpkgs-unstable";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };

    systems.url = "github:nix-systems/default-linux";
  };

  outputs = { nixpkgs, systems, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      eachSystem = lib.genAttrs (import systems);
    in {
      apps = eachSystem (system: {
        update = with nixpkgs.legacyPackages.${system}; {
          type = "app";
          program = let
            script = writeShellScript "update" ''
              set -euo pipefail
              export PATH=${lib.makeBinPath [ gitMinimal jq nixVersions.git hostname node2nix ]}
              export NIX_PATH=nixpkgs=${inputs.nixpkgs}
              ./update-vscode-plugins.py
              ./codelldb/update.sh
            '';
          in "${script}";
        };
      });

      overlays.default =
        final: prev: with builtins; rec {
          vscode-custom-extensions-all = prev.lib.attrsets.attrValues vscode-custom-extensions;

          vscode-custom-extensions =
            foldl' (
              acc: item: acc // { "${item.name}" = prev.vscode-utils.extensionFromVscodeMarketplace item; }
            ) { } (fromJSON (readFile ./extensions.json))
            // {
              codelldb = import ./codelldb { pkgs = prev; };
              continue = import ./continue { pkgs = prev; };
            };
        };
    };
}
