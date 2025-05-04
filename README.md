### 1  Prerequisites

| Package | Why it’s needed | Install (Debian/Ubuntu) | Install (macOS Homebrew) |
| --- | --- | --- | --- |
| **tmux** ≥ 2.9 | creates and manages panes | `sudo apt install tmux` | `brew install tmux` |
| **yq** v4 (Mike Farah) | parses your YAML layout | `sudo apt install yq`  <br>*(or `curl ‑Lo ~/bin/yq …`)* | `brew install yq` |
| **bash** / **zsh** | runs the script | pre‑installed | pre‑installed |

The script is POSIX‑compliant (works under any Bourne‑like shell) and requires no Python, Ruby, Node, or Docker.

* * *

### 2  Getting the script

```bash
# move it somewhere on your PATH
sudo install -m 755 ctmux.sh /usr/local/bin/ctmux.sh
```

*(or simply keep it in `~/bin` and add that to your PATH.)*

* * *

### 3  Quick start

```yaml
# ctmux.yaml – two panes left / right
layout:
  - split: none
    command: echo 'Left'
  - split: horizontal
    command: echo 'Right'

```

```
ctmux.sh -c ctmux.yaml -s demo
```

Result: two panes, the second created with `split-window -h`, so they sit  
side‑by‑side.

* * *

### 4  Layout grammar

| Key | Allowed values | Purpose |
| --- | --- | --- |
| `split` | `none` — use current pane without splitting  <br>`horizontal` — `tmux split-window -h` (side‑by‑side)  <br>`vertical` — `tmux split-window -v` (stacked) | How to create the pane. |
| `command` | Any shell command (default is your login shell) | What runs inside the pane. |
| `target` | `left` or `right` (optional) | Which **column** the pane belongs to; useful once you have both left & right columns active. |

No other keys are required; keep layouts simple and readable.

* * *

### 5  Examples

#### 5.1 Three‑pane “T” layout (1 left, 2 right‑stacked)

```yaml
layout:
  - split: none
    command: echo 'Left'
  - split: horizontal
    command: echo 'Right Top'
  - split: vertical
    command: echo 'Right Bottom'

```

Left pane is created first.  
Second pane splits to the **right**.  
Third pane splits **vertically** inside the right column.

#### 5.2 Four‑pane column layout (two left, two right)


```yaml
layout:
  - split: none
    command: htop
  - split: vertical
    command: tail -f /var/log/syslog
  - split: horizontal
    command: bash
  - split: vertical
    command: ssh user@remote

```

1.  `htop` in the initial pane.
    
2.  A bottom‑left log tail.
    
3.  New right column.
    
4.  Bottom‑right SSH.
    

#### 5.3 Single‑column stacking (three panes top‑down)

```yaml
layout:
  - split: none
    command: vim
  - split: vertical
    command: python
  - split: vertical
    command: bash

```

* * *

### 6  Handy aliases

Add to `~/.bashrc` or `~/.zshrc`:


```
alias ctmux='/home/bin/ctmux.sh'                       # bare script
alias ctmux_001='/home/bin/ctmux.sh -c /home/bin/ctmux.yaml -s'
````

Usage:

```
# launch a session called demo_session using your default YAML
ctmux_001 demo_session
```

You can create as many specialised aliases as you like, each pointing at a  
different YAML file or default session name.

* * *

### 7  Troubleshooting

| Symptom | Likely cause & fix |
| --- | --- |
| *“yq: command not found”* | Ensure you installed **Mike Farah’s yq v4** (the Go binary), not the Python 2.x package. |
| Panes appear top/bottom when you expect left/right | Remember: `split: horizontal` = **side‑by‑side**, `split: vertical` = **stacked**. |
| A command prints *“command not found”* with quotes | Remove the surrounding quotes from the `command:` value in YAML, e.g. `command: echo Hello`. |

* * *

### 8  Licence

MIT Licence — do what you like, no warranty.
