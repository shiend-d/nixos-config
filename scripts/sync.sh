#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="${XDG_CONFIG_HOME:-$HOME/.config}/niri"
target_dir="$repo_root/home/shiend/niri"
files=(config.kdl exec.kdl input.kdl keybinds.kdl layout.kdl rules.kdl)
noctalia_source="${XDG_STATE_HOME:-$HOME/.local/state}/noctalia/settings.toml"
noctalia_target="$repo_root/home/shiend/noctalia/settings.toml"

mkdir -p "$target_dir"
for file in "${files[@]}"; do
  source="$source_dir/$file"
  target="$target_dir/$file"
  if [[ ! -f "$source" ]]; then
    printf 'Missing Niri config: %s\n' "$source" >&2
    exit 1
  fi
  if [[ -e "$target" ]] && [[ "$source" -ef "$target" ]]; then
    printf 'Already linked: %s\n' "$file"
    continue
  fi
  cp -- "$source" "$target"
  printf 'Synced: %s\n' "$file"
done

if [[ ! -f "$noctalia_source" ]]; then
  printf 'Missing Noctalia settings: %s\n' "$noctalia_source" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$noctalia_target")"
python3 - "$noctalia_source" "$noctalia_target" <<'PY'
from pathlib import Path
import re, sys

source, target = map(Path, sys.argv[1:])
text = source.read_text()
text = re.sub(
    r'(?m)^(\s*(?:password|api_key|apikey|token|secret)\s*=).*$',
    r'\1 ""',
    text,
    flags=re.I,
)
target.write_text(text)
PY
printf 'Synced Noctalia settings with credential fields blanked.\n'

sync_file() {
  local app="$1" source="$2" target="$3"
  if [[ ! -f "$source" ]]; then
    printf 'Missing %s config: %s\n' "$app" "$source" >&2
    exit 1
  fi
  mkdir -p "$(dirname -- "$target")"
  if [[ -e "$target" ]] && [[ "$source" -ef "$target" ]]; then
    printf 'Already linked: %s\n' "$app"
    return
  fi
  cp -- "$source" "$target"
  printf 'Synced %s config.\n' "$app"
}

sync_file "Fish" "${XDG_CONFIG_HOME:-$HOME/.config}/fish/config.fish" "$repo_root/home/shiend/fish/config.fish"
sync_file "Kitty" "${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf" "$repo_root/home/shiend/kitty/kitty.conf"
mkdir -p "$repo_root/home/shiend/starship"
cp -- "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml" "$repo_root/home/shiend/starship/starship.toml"
printf 'Synced Starship config.\n'
