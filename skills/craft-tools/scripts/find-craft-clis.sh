#!/bin/sh
# Print the path of each ArtCraft app CLI, or "missing".
# Works on macOS and Linux. Reads the filesystem only: no network, no writes.
set -u

status=0
os="$(uname -s 2>/dev/null || echo unknown)"
case "$os" in
  Darwin) platform="macOS" ;;
  Linux) platform="Linux" ;;
  MINGW*|MSYS*|CYGWIN*) platform="Windows shell" ;;
  *) platform="$os" ;;
esac

user_bin="${HOME:-}/.local/bin"
printf 'platform=%s\n' "$platform"

find_cli() {
  name="$1"
  shift
  for candidate in "$@"; do
    [ -n "$candidate" ] || continue
    if [ -x "$candidate" ]; then
      printf '%s=%s\n' "$name" "$candidate"
      return 0
    fi
  done
  printf '%s=missing\n' "$name"
  status=1
  return 1
}

find_cli figcraft \
  "${FIGCRAFT_CLI:-}" \
  "$(command -v figcraft-cli 2>/dev/null || true)" \
  "$user_bin/figcraft-cli" \
  "/usr/bin/figcraft-cli" \
  "/usr/local/bin/figcraft-cli"

find_cli filmcraft \
  "${FILMCRAFT_CLI:-}" \
  "$(command -v filmcraft-cli 2>/dev/null || true)" \
  "$user_bin/filmcraft-cli" \
  "/usr/bin/filmcraft-cli" \
  "/usr/local/bin/filmcraft-cli" \
  "${HOME:-}/.local/share/filmcraft-cli/filmcraft-cli"

find_cli anicraft \
  "${ANICRAFT_CLI:-}" \
  "$(command -v anicraft-cli 2>/dev/null || true)" \
  "$user_bin/anicraft-cli" \
  "/usr/bin/anicraft-cli" \
  "/usr/local/bin/anicraft-cli" \
  "/Applications/AniCraft.app/Contents/MacOS/anicraft-cli"

find_cli effectcraft \
  "${EFFECTCRAFT_CLI:-}" \
  "$(command -v effectcraft-cli 2>/dev/null || true)" \
  "$user_bin/effectcraft-cli" \
  "/usr/bin/effectcraft-cli" \
  "/usr/local/bin/effectcraft-cli" \
  "${HOME:-}/.local/share/effectcraft-cli/effectcraft-cli"

find_cli vectorcraft \
  "${VECTORCRAFT_CLI:-}" \
  "$(command -v vectorcraft-cli 2>/dev/null || true)" \
  "$user_bin/vectorcraft-cli" \
  "/usr/bin/vectorcraft-cli" \
  "/usr/local/bin/vectorcraft-cli" \
  "${HOME:-}/.local/share/vectorcraft-cli/vectorcraft-cli"

if [ "$status" -ne 0 ]; then
  echo "note=Install the missing ArtCraft app, or set the matching *_CLI variable." >&2
  if [ "$platform" = "Linux" ]; then
    echo "note=AppImage users: run the AppImage with the cli subcommand, e.g. ./FigCraft.AppImage cli --help." >&2
  fi
  if [ "$platform" = "Windows shell" ]; then
    echo "note=Use scripts/find-craft-clis.ps1 in PowerShell for the Windows paths." >&2
  fi
fi

exit "$status"
