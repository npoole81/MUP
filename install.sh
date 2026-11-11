#!/bin/bash
#
# MUP installer
#
#   curl -fsSL https://raw.githubusercontent.com/npoole81/MUP/master/install.sh | bash
#
# Options (environment variables):
#   MUP_INSTALL_DIR  where to install (default: ~/.local/bin)
#   MUP_REF          branch or tag to install from (default: master)
#
# Example:
#   curl -fsSL https://raw.githubusercontent.com/npoole81/MUP/master/install.sh | MUP_INSTALL_DIR=/usr/local/bin bash
#
# An existing mup-menu.conf is never overwritten; the new default is saved as
# mup-menu.conf.new instead.

set -euo pipefail

REPO="npoole81/MUP"
REF="${MUP_REF:-master}"
DIR="${MUP_INSTALL_DIR:-$HOME/.local/bin}"
BASE="https://raw.githubusercontent.com/$REPO/$REF/bin"

say()  { printf '%s\n' "$*"; }
fail() { printf 'mup install: %s\n' "$*" >&2; exit 1; }

if command -v curl >/dev/null 2>&1; then
    fetch() { curl -fsSL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
    fetch() { wget -q "$1" -O "$2"; }
else
    fail "curl or wget is required"
fi

mkdir -p "$DIR" 2>/dev/null || fail "cannot create $DIR (try MUP_INSTALL_DIR=... or run with sudo)"
[ -w "$DIR" ] || fail "$DIR is not writable (try MUP_INSTALL_DIR=... or run with sudo)"

TMP=$(mktemp -d 2>/dev/null || mktemp -d -t mup)
trap 'rm -rf "$TMP"' EXIT

say "Downloading mup ($REF) ..."
fetch "$BASE/mup" "$TMP/mup"                     || fail "download failed: $BASE/mup"
fetch "$BASE/mup-menu.conf" "$TMP/mup-menu.conf" || fail "download failed: $BASE/mup-menu.conf"

head -n 1 "$TMP/mup" | grep -q '^#!.*bash' || fail "downloaded file does not look like the mup script"

install -m 755 "$TMP/mup" "$DIR/mup"
say "Installed $DIR/mup"

if [ -f "$DIR/mup-menu.conf" ]; then
    if cmp -s "$TMP/mup-menu.conf" "$DIR/mup-menu.conf"; then
        say "Default menu is already up to date"
    else
        install -m 644 "$TMP/mup-menu.conf" "$DIR/mup-menu.conf.new"
        say "Kept your existing $DIR/mup-menu.conf (new default saved as mup-menu.conf.new)"
    fi
else
    install -m 644 "$TMP/mup-menu.conf" "$DIR/mup-menu.conf"
    say "Installed $DIR/mup-menu.conf"
fi

case ":$PATH:" in
    *":$DIR:"*) say ""; say "Done. Run 'mup' to get started." ;;
    *)
        say ""
        say "Done, but $DIR is not on your PATH. Add this to your shell profile:"
        say ""
        say "  export PATH=\"\$PATH:$DIR\""
        ;;
esac
