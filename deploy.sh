#!/usr/bin/env bash
# Deploy the Riverbed theme into a FreshRSS themes directory.
#
# Set DEST to your FreshRSS theme path (default below is a bind-mount source):
#   DEST=/var/www/FreshRSS/p/themes/Riverbed ./deploy.sh
#
# FreshRSS's Apache serves theme assets with Cache-Control: max-age=2592000
# (30 days) and only the metadata-listed CSS gets an mtime cache-buster query.
# Runtime @import partials would therefore go stale for up to a month after
# an update — so the partials are a source-only structure: this script inlines
# them into a single deployed riverbed.css. CSS changes need no restart.
set -euo pipefail
THEME=Riverbed
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$THEME"
DEST="${DEST:-/data/freshrss/themes/$THEME}"
mkdir -p "$DEST"

# Everything except CSS sources (fonts, icons, thumbs, metadata).
rsync -rt --delete --chmod=D755,F644 --exclude='*.css' "$SRC/" "$DEST/"
# Partials are never served (they are inlined below); drop any strays.
find "$DEST" -maxdepth 1 -name '_*.css' -delete

# Bundle: replace each @import "<file>"; with the file's contents, in order.
bundle="$DEST/riverbed.css.tmp"
while IFS= read -r line; do
	if [[ $line =~ ^@import\ \"([^\"]+)\"\; ]]; then
		printf '\n/* ==== %s ==== */\n' "${BASH_REMATCH[1]}"
		cat "$SRC/${BASH_REMATCH[1]}"
	else
		printf '%s\n' "$line"
	fi
done < "$SRC/riverbed.css" > "$bundle"

# Only touch the served file when content actually changed (mtime = cache key).
if ! cmp -s "$bundle" "$DEST/riverbed.css" 2>/dev/null; then
	mv "$bundle" "$DEST/riverbed.css"
else
	rm "$bundle"
fi
chmod 644 "$DEST/riverbed.css"

# RTL variant: the loader swaps riverbed.css -> riverbed.rtl.css for RTL
# locales. The theme uses logical properties, so an identical copy is correct.
cp -p "$DEST/riverbed.css" "$DEST/riverbed.rtl.css"

echo "Deployed to $DEST ($(wc -c < "$DEST/riverbed.css") bytes bundled)"
