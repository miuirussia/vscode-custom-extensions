{ pkgs }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension rec {
  vsix = builtins.fetchurl {
    name = "continue.zip";
    url = "https://github.com/miuirussia/continue/releases/download/v1.4.41/continue-1.3.8-60fc293.vsix";
    sha256 = "aa02d7d046e63c9ff9fcd3f6a997e8747d28786f77eb1341066ccab2978c9601";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    libgcc
    stdenv.cc.cc.lib
    zlib
  ];

  mktplcRef = {
    publisher = "Continue";
    name = "continue";
    version = "1.3.8";
  };
}
