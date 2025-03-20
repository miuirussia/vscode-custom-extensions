{ pkgs }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  vsix = ./continue-1.1.12.zip;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    libgcc
    stdenv.cc.cc.lib
    zlib
  ];

  mktplcRef = {
    publisher = "Continue";
    name = "continue";
    version = "1.1.12";
  };
}
