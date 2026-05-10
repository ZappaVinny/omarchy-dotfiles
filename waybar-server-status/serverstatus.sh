#!/bin/bash

CONF="${XDG_CONFIG_HOME:-$HOME/.config}/waybar/serverstatus.conf"

check_server() {
  local name="$1" url="$2" tmpfile="$3"
  local code
  code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 2 --max-time 3 "$url" 2>/dev/null)
  if [[ "$code" =~ ^[23] ]]; then
    echo "up:${name}" >> "$tmpfile"
  else
    echo "down:${name}" >> "$tmpfile"
  fi
}

tmpfile=$(mktemp)
order=()

while IFS='|' read -r name url || [[ -n "$name" ]]; do
  name="${name#"${name%%[! ]*}"}"
  name="${name%"${name##*[! ]}"}"
  url="${url// /}"
  [[ -z "$name" || -z "$url" ]] && continue
  order+=("$name")
  check_server "$name" "$url" "$tmpfile" &
done < "$CONF"

wait

declare -A status_map
while IFS=: read -r state name; do
  status_map["$name"]="$state"
done < "$tmpfile"
rm -f "$tmpfile"

up=0; down=0; tooltip=""
for name in "${order[@]}"; do
  if [[ "${status_map[$name]}" == "up" ]]; then
    (( up++ ))
    tooltip+="${name} ✓\n"
  else
    (( down++ ))
    tooltip+="${name} ✗\n"
  fi
done

tooltip="${tooltip%\\n}"
tooltip+="\n\nLast polled: $(date '+%H:%M:%S')"

if   (( down == 0 )); then class="all-up"
elif (( up  == 0 )); then class="all-down"
else                       class="some-down"
fi

printf '{"text":"󰒋","tooltip":"%s","class":"%s"}\n' "$tooltip" "$class"
