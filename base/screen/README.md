# GNU Screen Configuration

Tmux-compatible GNU Screen setup with vim-style keybindings.

## Quick Start

```bash
screen              # Start new session
screen -ls          # List sessions
screen -r           # Reattach to session
screen -r <name>    # Reattach to specific session
screen -S <name>    # Start named session
screen -d -r        # Detach elsewhere and reattach here
```

## Prefix Key

**`C-a`** (Ctrl+a) - All commands below require pressing the prefix first

> **Note**: This differs from the tmux config which uses `C-space`. Screen doesn't support C-space as a prefix key.

## Most Common Operations

### Session Management
| Key | Action |
|-----|--------|
| `C-a d` | Detach from session |
| `C-a :quit` | Quit screen entirely |

### Windows (like tmux windows)
| Key | Action |
|-----|--------|
| `C-a c` | Create new window |
| `C-a t` | Create new window (tmux-style) |
| `C-a n` | Next window |
| `C-a p` | Previous window |
| `C-a C-a` | Toggle between last two windows |
| `C-a 0-9` | Switch to window 0-9 |
| `C-a w` | Window list (interactive) |
| `C-a "` | Window list (interactive) |
| `C-a K` | Kill current window |
| `C-a A` | Rename current window |

### Splits/Panes
| Key | Action |
|-----|--------|
| `C-a -` | Split horizontally |
| `C-a \|` | Split vertically |
| `C-a \\` | Split vertically (alternative) |
| `C-a =` | Split vertically (alternative) |
| `C-a Tab` | Cycle through panes |
| `C-a x` | Remove current pane |
| `C-a Q` | Kill all panes except current |
| `C-a z` | Zoom/maximize current pane |

### Pane Navigation (vim-style)
| Key | Action |
|-----|--------|
| `C-a h` | Move to left pane |
| `C-a j` | Move to down pane |
| `C-a k` | Move to up pane |
| `C-a l` | Move to right pane |

### Pane Resizing
| Key | Action |
|-----|--------|
| `C-a H` | Shrink horizontally |
| `C-a L` | Grow horizontally |
| `C-a J` | Shrink vertically |
| `C-a K` | Grow vertically |

### Copy Mode (scrollback)
| Key | Action |
|-----|--------|
| `C-a [` | Enter copy mode |
| `C-a Escape` | Enter copy mode (alternative) |
| `Space` | Start selection (in copy mode) |
| `Enter` | Copy selection (in copy mode) |
| `Escape` | Exit copy mode |
| `C-a ]` | Paste buffer |
| `C-a b` | Paste buffer (tmux-style) |
| `C-a P` | Paste buffer (alternative) |

**In copy mode:**
- `h/j/k/l` - Move cursor (vim-style)
- `C-b/C-f` - Page up/down
- `0/$` - Start/end of line
- `/` - Search forward
- `?` - Search backward

### Other Useful Commands
| Key | Action |
|-----|--------|
| `C-a r` | Reload configuration |
| `C-a :` | Command prompt |
| `C-a ;` | Command prompt (tmux-style) |
| `C-a ?` | Show help/keybindings |
| `C-a L` | Toggle logging |
| `C-a C-l` | Clear screen |

## Custom Keybindings (Different from Default)

These keybindings have been customized to match tmux behavior:

| Key | Default Screen | This Config | Reason |
|-----|---------------|-------------|---------|
| `C-a -` | (none) | Horizontal split | Match tmux |
| `C-a \|` | (none) | Vertical split | Match tmux |
| `C-a h/j/k/l` | (none) | Vim-style pane navigation | Match tmux/vim |
| `C-a H/J/K/L` | (none) | Pane resizing | Match tmux |
| `C-a t` | (none) | New window | Match tmux `C-t` |
| `C-a z` | Suspend | Zoom pane | Match tmux zoom |
| `C-a ;` | (none) | Command prompt | Match tmux |
| `C-a b` | Break window | Paste buffer | Match tmux |
| `C-a r` | (none) | Reload config | Match tmux |
| `C-a x` | Lock screen | Remove pane | Match tmux |

## Configuration Location

- Config file: `~/.screenrc`
- Stow package: `base/screen/`

## Installation

From the `base/` directory:
```bash
cd ~/dotfiles/base
stow screen
```

Or use the helper scripts:
```bash
./base/stowthis screen
```

## Differences from Tmux

1. **Prefix key**: `C-a` instead of `C-space` (Screen limitation)
2. **No mouse support**: Screen has very limited mouse capabilities
3. **No plugins**: Screen doesn't have a plugin manager like TPM
4. **No popup windows**: Screen doesn't support popup displays
5. **Split behavior**: Screen's splits work differently than tmux
6. **Copy mode**: Similar but not identical to tmux
7. **Status bar**: Different formatting capabilities

## Tips

- **Send literal C-a**: Press `C-a a` to send C-a to the application
- **Nested sessions**: Use `C-a C-a` to send commands to nested screen
- **Detach others**: `screen -d -r` to detach other connections and reattach
- **Multi-user**: Screen supports multi-user sessions with `multiuser on`
- **Logging**: `C-a L` to log all output to a file

## Common Issues

**Q: Why C-a instead of C-space?**  
A: GNU Screen doesn't support C-space as a prefix key. C-a is the standard.

**Q: Splits don't work like tmux?**  
A: Screen's split implementation is older and less flexible. Panes share the same window.

**Q: How do I scroll back?**  
A: Enter copy mode with `C-a [`, then use vim keys or arrow keys to navigate.

**Q: Mouse doesn't work?**  
A: Screen has very limited mouse support compared to tmux. Use keyboard navigation.

## Resources

- Official manual: `man screen`
- Help within screen: `C-a ?`
- Command list: `C-a :help`
