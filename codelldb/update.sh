#!/usr/bin/env nix-shell
#! nix-shell -i bash -p coreutils curl jq nixVersions.git
set -euo pipefail

cd "$(pwd)/$(dirname "${BASH_SOURCE}")" || exit
version=$(curl -L "https://api.github.com/repos/vadimcn/vscode-lldb/tags" | jq -r ".[0].name")
if [ -z "$version" ]
then
  echo "version fetch failed"
  exit 1
fi

url="https://github.com/vadimcn/vscode-lldb/releases/download/$version/codelldb-linux-x64.vsix"
sha256=$(nix-prefetch-url $url)

echo -n "$version" | tee version
echo "{}" \
  | jq ".url=\"$url\" | .sha256=\"$sha256\" | .name=\"vscode-lldb.zip\"" \
  | tee source.json
