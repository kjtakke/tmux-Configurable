#!/usr/bin/env bash
# ---------------------------------------------------------------------------
#  ctmux.sh – Create a tmux session from a YAML layout spec
# ---------------------------------------------------------------------------
set -euo pipefail

print_help() {
cat <<'EOF'
Usage: ctmux.sh -c CONFIG.yaml [-s SESSION]

YAML per‑pane keys
  split  : none | horizontal | vertical
  command: shell command (defaults to $SHELL)
  target : left | right   (optional, default left)
EOF
}

CONFIG="" ; SESSION="custom_session"
while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--config) CONFIG="$2"; shift 2 ;;
    -s|--session) SESSION="$2"; shift 2 ;;
    -h|--help)    print_help; exit 0 ;;
    *) echo "Unknown option $1"; print_help; exit 1 ;;
  esac
done
[[ -z "${CONFIG:-}" || ! -f $CONFIG ]] && { echo "Need -c CONFIG.yaml"; exit 1; }
command -v yq >/dev/null || { echo "yq not found"; exit 1; }
command -v tmux >/dev/null || { echo "tmux not found"; exit 1; }

tmux has-session -t "$SESSION" 2>/dev/null && tmux kill-session -t "$SESSION"

# ---- read YAML (raw strings, no quoting) -----------------------------------
mapfile -t SPLIT < <(yq -r '.layout[].split'             "$CONFIG")
mapfile -t CMD   < <(yq -r '.layout[].command // ""'     "$CONFIG")
mapfile -t TG    < <(yq -r '.layout[].target  // "left"' "$CONFIG")
mapfile -t WID   < <(yq -r '.layout[].width   // ""'     "$CONFIG")
mapfile -t HGT   < <(yq -r '.layout[].height  // ""'     "$CONFIG")

tmux new-session -d -s "$SESSION"
tmux rename-window -t "$SESSION:0" main

LEFT=""   # most‑recent left‑column pane
RIGHT=""  # most‑recent right‑column pane

for i in "${!SPLIT[@]}"; do
  sp=${SPLIT[i]}
  cmd=${CMD[i]:-$SHELL}
  tgt=${TG[i]:-left}
  w=${WID[i]:-}
  h=${HGT[i]:-}

  # first pane or explicit 'none'
  if [[ $i -eq 0 || $sp == none ]]; then
    tmux send-keys -t "$SESSION" "$cmd" C-m
    LEFT=$(tmux display -p -t "$SESSION" "#{pane_id}")
    continue
  fi

  # build size flag (-p % or -l N)
  size_flag=()
  if [[ $sp == vertical && -n $h ]]; then
       [[ $h == *% ]] && size_flag=(-p "${h%%%}") || size_flag=(-l "$h")
  elif [[ $sp == horizontal && -n $w ]]; then
       [[ $w == *% ]] && size_flag=(-p "${w%%%}") || size_flag=(-l "$w")
  fi

  # decide base pane
  if [[ $tgt == right ]]; then
       if [[ -z $RIGHT ]]; then           # first ever right pane
            tmux select-pane -t "$LEFT"
            tmux split-window -h "${size_flag[@]}" -t "$SESSION"
            RIGHT=$(tmux display -p "#{pane_id}")
            tmux send-keys -t "$RIGHT" "$cmd" C-m
            continue
       fi
       tmux select-pane -t "$RIGHT"
  else
       tmux select-pane -t "$LEFT"
  fi

  # split from the selected pane
  if [[ $sp == vertical ]]; then
       tmux split-window -v "${size_flag[@]}" -t "$SESSION"
  else
       tmux split-window -h "${size_flag[@]}" -t "$SESSION"
  fi

  NEW=$(tmux display -p "#{pane_id}")
  tmux send-keys -t "$NEW" "$cmd" C-m
  [[ $tgt == right ]] && RIGHT=$NEW || LEFT=$NEW
done

tmux attach -t "$SESSION"
