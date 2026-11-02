#!/usr/bin/env bash
# Bu makinedeki Herdr ayarlarını repoya kopyalar. Değişiklikten sonra çalıştır, sonra commit et.
set -euo pipefail
SRC="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
DST="$(cd "$(dirname "$0")" && pwd)/herdr-app"
source "$(dirname "$0")/files.sh"
rm -rf "$DST"; mkdir -p "$DST"
for f in "${FILES[@]}" "${MODS[@]/#/mods/}"; do
  mkdir -p "$DST/$(dirname "$f")"
  rsync -a --exclude '*.d.ts' --exclude jsconfig.json --exclude node_modules "$SRC/$f" "$DST/$(dirname "$f")/"
done
echo "Kopyalandı: $DST"
