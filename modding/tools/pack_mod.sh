#!/bin/zsh
# pack_mod.sh <mod folder> [out dir]: makes <id>.zip, one file a player drops into the game's mods folder.
# The zip holds mods/<id>/..., which is where the game mounts it (res://mods/<id>/).
set -e
src=${1:?usage: pack_mod.sh <mod folder> [out dir]}
out=${2:-$(dirname "$src")/dist}
id=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['id'])" "$src/mod.json")
tmp=$(mktemp -d)
mkdir -p "$tmp/mods/$id" "$out"
out=$(cd "$out" && pwd)
cp -R "$src"/. "$tmp/mods/$id/"
rm -f "$out/$id.zip"
(cd "$tmp" && zip -qr "$out/$id.zip" mods -x "*.DS_Store")
rm -rf "$tmp"
echo "$out/$id.zip"
