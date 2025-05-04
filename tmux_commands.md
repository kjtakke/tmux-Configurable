| Command | Description | Category |
|---------|-------------|----------|
| `tmux new -s <name>` | Create a new detached session | Session Mgmt |
| `tmux attach -t <name>` | Attach to an existing session | Session Mgmt |
| `tmux detach` | Detach (leave) the current session | Session Mgmt |
| `tmux kill-session -t <name>` | Destroy an entire session | Session Mgmt |
| `tmux list-sessions` | Show all running sessions | Session Mgmt |
| `tmux rename-session -t <old> <new>` | Rename a session | Session Mgmt |
| `tmux switch-client -t <name>` | Move the current client to another session | Session Mgmt |
| `tmux new-window -n <title>` | Create a new window in the current session | Window Mgmt |
| `tmux kill-window -t :<idx>` | Close (kill) a window by index | Window Mgmt |
| `tmux next-window` / `previous-window` | Move between windows | Window Mgmt |
| `tmux select-window -t :<idx>` | Select a window by index | Window Mgmt |
| `tmux rename-window -t :<idx> <title>` | Rename a window | Window Mgmt |
| `tmux move-window -s :<idx> -t :<newidx>` | Re‑order a window | Window Mgmt |
| `tmux list-windows` | List all windows in current session | Window Mgmt |
| `tmux split-window -h` | Split active pane left/right (vertical divider) | Pane Mgmt |
| `tmux split-window -v` | Split active pane top/bottom (horizontal divider) | Pane Mgmt |
| `tmux kill-pane -t <pane>` | Close the specified pane | Pane Mgmt |
| `tmux select-pane -t <pane>` | Make a pane active | Pane Mgmt |
| `tmux swap-pane -s <p1> -t <p2>` | Swap two panes | Pane Mgmt |
| `tmux list-panes` | List panes in current window | Pane Mgmt |
| `tmux resize-pane -L/R/U/D <N>` | Resize active pane (left/right/up/down) | Pane Mgmt |
| `tmux select-layout tiled` | Apply tiled layout | Layouts |
| `tmux select-layout even-horizontal` | Evenly stack panes top/bottom | Layouts |
| `tmux select-layout even-vertical` | Evenly arrange panes left/right | Layouts |
| `tmux save-buffer <file>` | Save tmux paste buffer to a file | Copy & Buffer |
| `tmux load-buffer <file>` | Load a file into the paste buffer | Copy & Buffer |
| `tmux capture-pane -S -32768` | Copy entire scrollback into buffer | Copy & Buffer |
| `tmux set -g <option> <value>` | Set a global option at runtime | Configuration |
| `tmux show-options -g` | List global options | Configuration |
| `tmux bind-key <key> <command>` | Add a custom key binding | Configuration |
| `tmux unbind-key <key>` | Remove a key binding | Configuration |
| `tmux source-file ~/.tmux.conf` | Reload tmux configuration file | Configuration |
| `tmux send-keys "cmd" C-m` | Type & enter a command in active pane | Automation |
| `tmux run-shell "<script>"` | Run a shell script inside tmux | Automation |
| `tmux pipe-pane -o 'cat >>log'` | Pipe pane output to a log file | Automation |
| `tmux display-message "text"` | Show a status‑line message | Misc |
| `tmux clear-history` | Clear scrollback for active pane | Misc |
| `tmux clock-mode` | Display a big ASCII clock | Misc |
| `tmux server-info` | Dump server diagnostics | Diagnostics |
| `tmux list-commands` | List all tmux commands with help | Help & Docs |
| `tmux list-keys` | Show all active key bindings | Help & Docs |

| Keybinding (Prefix + ...) | Action | Category |
|---------------------------|--------|----------|
| `Ctrl + b` then `?`       | Show all key bindings | Help |
| `Ctrl + b` then `d`       | Detach from session | Session Mgmt |
| `Ctrl + b` then `s`       | List sessions | Session Mgmt |
| `Ctrl + b` then `$`       | Rename current session | Session Mgmt |
| `Ctrl + b` then `c`       | Create a new window | Window Mgmt |
| `Ctrl + b` then `,`       | Rename current window | Window Mgmt |
| `Ctrl + b` then `&`       | Kill current window | Window Mgmt |
| `Ctrl + b` then `p`       | Previous window | Window Mgmt |
| `Ctrl + b` then `n`       | Next window | Window Mgmt |
| `Ctrl + b` then `l`       | Last (previously used) window | Window Mgmt |
| `Ctrl + b` then `w`       | Choose window from list | Window Mgmt |
| `Ctrl + b` then `%`       | Split pane vertically (side-by-side) | Pane Mgmt |
| `Ctrl + b` then `"`       | Split pane horizontally (top/bottom) | Pane Mgmt |
| `Ctrl + b` then `x`       | Kill current pane | Pane Mgmt |
| `Ctrl + b` then `o`       | Go to next pane | Pane Mgmt |
| `Ctrl + b` then `;`       | Go to last active pane | Pane Mgmt |
| `Ctrl + b` then `q`       | Show pane numbers | Pane Mgmt |
| `Ctrl + b` then `{`       | Move pane left | Pane Mgmt |
| `Ctrl + b` then `}`       | Move pane right | Pane Mgmt |
| `Ctrl + b` then `z`       | Toggle zoom on current pane | Pane Mgmt |
| `Ctrl + b` then `Space`   | Cycle through layouts | Layouts |
| `Ctrl + b` then `t`       | Show a clock in the pane | Misc |
| `Ctrl + b` then `[`       | Enter copy mode | Copy & Scrollback |
| `Ctrl + b` then `]`       | Paste from buffer | Copy & Scrollback |
| `Ctrl + b` then `:`       | Enter command mode | Advanced |
| `Ctrl + b` then `!`       | Break pane into a new window | Window Mgmt |
| `Ctrl + b` then `Ctrl + Arrow` | Resize pane (one cell) | Pane Mgmt |
