#!/usr/bin/env bash
# Repodaki Herdr ayarlarını bu makineye kurar. Üzerine yazılan dosyaların yedeği alınır.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/herdr-app"
DST="${HERDR_APP_HOME:-$HOME/.config/herdr-app}"
source "$HERE/files.sh"
[ -d "$DST" ] || { echo "$DST yok. Herdr'ı kurup bir kez aç, sonra tekrar çalıştır."; exit 1; }
BACKUP="$DST.backup-$(date +%Y%m%d-%H%M%S)"
for f in "${FILES[@]}" "${MODS[@]/#/mods/}"; do
  if [ -e "$DST/$f" ]; then mkdir -p "$BACKUP/$(dirname "$f")"; cp -R "$DST/$f" "$BACKUP/$(dirname "$f")/"; rm -rf "$DST/$f"; fi
  mkdir -p "$DST/$(dirname "$f")"
  cp -R "$SRC/$f" "$DST/$(dirname "$f")/"
done
[ -d "$BACKUP" ] && echo "Eski dosyaların yedeği: $BACKUP"
fail=0
for m in "${MODS[@]}"; do herdr-app check "$DST/mods/$m" || fail=1; done
herdr-app do layout.switch "{\"name\":\"$LAYOUT\"}" >/dev/null 2>&1 || echo "Layout'u geçmek için Herdr açık olmalı: herdr-app do layout.switch '{\"name\":\"$LAYOUT\"}'"
echo
echo "Gerekenler:"
command -v quota-axi >/dev/null || echo "  - quota: npm install -g quota-axi && quota-axi --allow-keychain-prompt"
command -v gh >/dev/null || echo "  - issues: gh kur ve gh auth login"
command -v node >/dev/null || echo "  - revive: node"
command -v git >/dev/null || echo "  - git"
exit $fail
