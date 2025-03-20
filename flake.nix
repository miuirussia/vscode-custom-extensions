{
  description = "VSCode Extensions";

  inputs = {
    nixpkgs.url = "github:miuirussia/nixpkgs/nixpkgs-unstable";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
  };

  outputs = { self, nixpkgs, ... }:
    {
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
