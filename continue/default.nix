{ pkgs }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension rec {
  vsix = builtins.fetchurl {
    name = "continue-1.3.2.zip";
    url = "https://github.com/miuirussia/continue/releases/download/v1.3.2/continue-linux-x64-1.3.2.vsix";
    sha256 = "4500e666c9b954d29ce6ba46207d5025a3d59381761d120a8ad86c1cb39718b3";
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
    version = "1.3.2";
  };
}
