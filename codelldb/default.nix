{ pkgs }:

with builtins;

pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  vsix = fetchurl (fromJSON (readFile ./source.json));

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    libgcc
    zlib
  ];

  mktplcRef = {
    publisher = "vadimcn";
    name = "vscode-lldb";
    version = readFile ./version;
  };
}
