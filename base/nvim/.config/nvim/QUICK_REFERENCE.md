# Neovim Quick Reference

## Essential Keymaps

### Leader Key: `Space`  |  Local Leader: `,`

## Most Used Commands

### Search & Navigation (FZF-Lua)
| Key | Action |
|-----|--------|
| `<leader>f` or `<leader>;` | Find files |
| `<leader>st` | Live grep (search text) |
| `<leader>/` | Search in current buffer |
| `<leader>bb` | Switch buffers |
| `<leader>sp` | Recent files |
| **In FZF**: `Ctrl-Q` or `Alt-Q` | Send to quickfix |

### File Explorer
| Key | Action |
|-----|--------|
| `-` | Open Oil.nvim file browser |
| `<leader>xf` | Open Yazi (if installed) |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gu` | Find references |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `<F2>` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>cf` | Format |
| `[d` / `]d` | Prev/next diagnostic |

### AI (Copilot)
| Key | Action |
|-----|--------|
| `Alt-Enter` | Accept suggestion |
| `Alt-w` | Accept word |
| `Alt-j` | Accept line |
| `Alt-]` / `Alt-[` | Next/prev suggestion |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gP` | Git pull |
| `<leader>gh` | Preview hunk |
| `<leader>xg` | LazyGit TUI |

### Terminal
| Key | Action |
|-----|--------|
| `<leader>xx` | Floating terminal |
| `<leader>xg` | LazyGit |
| `<leader>xd` | LazyDocker |
| `<leader>xp` | Python REPL |

### Testing
| Key | Action |
|-----|--------|
| `<leader>tt` | Test nearest |
| `<leader>tf` | Test file |
| `<leader>ts` | Test summary |

### Buffers & Windows
| Key | Action |
|-----|--------|
| `<leader>w` | Save all |
| `<leader>q` | Close window |
| `<leader>bd` | Delete buffer |
| `<leader>-` | Split horizontal |
| `<leader>\` | Split vertical |
| `Shift-Tab` | Next buffer |

### Editing
| Key | Action |
|-----|--------|
| `gcc` | Toggle comment line |
| `gc` | Toggle comment (motion) |
| `gb` | Toggle comment block |
| `jk` | Exit insert mode |
| `;` | Command mode (`:`) |
| `<leader>p` | Paste without yank |

### Diagnostics & Trouble
| Key | Action |
|-----|--------|
| `<leader>id` | Document diagnostics |
| `<leader>iq` | Quickfix list |
| `<leader>co` | Symbols sidebar |

## Pro Tips

1. **Quickfix from search**: Use `<leader>st` to search, then `Ctrl-Q` to send all results to quickfix
2. **Oil.nvim**: Press `-` anywhere to browse files like a buffer
3. **Copilot**: `Alt-Enter` accepts AI suggestions without conflicts
4. **LazyGit**: `<leader>xg` for full-featured git TUI
5. **Type definition**: Use `gy` (goto type) instead of old `gb`
6. **Fold navigation**: Use `za` to toggle folds in plugins.lua

## File Locations

- Main config: `~/.config/nvim/init.lua`
- All plugins: `~/.config/nvim/lua/plugins.lua`
- Settings: `~/.config/nvim/lua/core.lua`
- Keymaps: `~/.config/nvim/lua/yasser/keymaps.lua`

## Quick Actions

- Install/Update plugins: `:Lazy sync`
- Install LSP servers: `:Mason`
- Check health: `:checkhealth`
- View plugin status: `:Lazy`
- Clear search highlight: `<Esc><Esc>`

## LaTeX (VimTeX)

Continuous compilation is enabled - just save and your PDF updates automatically!
- Viewer: Skim (macOS)
- Engine: LuaLaTeX (fast)
- Build dir: `build/` (keeps root clean)
