{ pkgs }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension rec {
  vsix = builtins.fetchurl {
    url = "https://github.com/miuirussia/vscode-custom-extensions/releases/download/assets-r1/continue-1.1.67.vsix";
    sha256 = "0yrzn66c32wscnx9drb5fbp2jx8nysgcykgkvjkfisxxymwg87fm";
  };

  unpackPhase = ''
    runHook preUnpack
    unzip ${vsix}
    runHook postUnpack
  '';

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    libgcc
    stdenv.cc.cc.lib
    zlib
  ];

  mktplcRef = {
    publisher = "Continue";
    name = "continue";
    version = "1.1.67";
  };
}
