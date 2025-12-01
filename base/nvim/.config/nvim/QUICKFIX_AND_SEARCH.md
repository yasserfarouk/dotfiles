# Quickfix and Search Guide

## FZF-Lua Search to Quickfix

### Moving All Results to Quickfix
When you perform a search (e.g., `<leader>st` for live grep), you can send results to the quickfix list:

- **Ctrl-Q** or **Alt-Q**: Send all results to quickfix list

### Moving Selected Results to Quickfix
1. Use **Tab** to select/deselect individual items
2. Press **Ctrl-Q** or **Alt-Q** to send selected items to quickfix

### Quickfix Navigation
- `]q` - Next quickfix item
- `[q` - Previous quickfix item
- `<leader>iq` - Open quickfix list in Trouble
- `<leader>ax` - Close quickfix list

## Search Commands Reference

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>st` | Live grep | Search text in all files |
| `<leader>sw` | Grep word | Search word under cursor |
| `<leader>sf` | Find files | Find files by name |
| `<leader>sg` | Buffer search | Search in current buffer |
| `<leader>sp` | Recent files | Search recently opened files |
| `<leader>sb` | Git branches | Search git branches |
| `<leader>sh` | File history | Git commits for current file |
| `<leader>ss` | Document symbols | Search LSP symbols in file |
| `<leader>cd` | Diagnostics | Search diagnostics in file |

## Copilot AI Suggestions

### Accepting Suggestions
- **Alt-Enter** (`<M-CR>`): Accept full suggestion
- **Alt-w**: Accept next word
- **Alt-j**: Accept next line
- **Alt-]**: Next suggestion
- **Alt-[**: Previous suggestion
- **Ctrl-]**: Dismiss suggestion

## LSP Features

All LSP features are available via keymaps defined when an LSP server attaches:

| Keymap | Action |
|--------|--------|
| `gd` | Go to definition |
| `gu` | Find references |
| `K` | Hover documentation |
| `<F2>` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>cf` | Format document |
| `[d` / `]d` | Navigate diagnostics |
| `[e` / `]e` | Navigate errors only |

## Notes

- Fidget.nvim provides LSP progress indicators (bottom-right corner)
- All borders are rounded for consistency
- Tree-sitter provides syntax highlighting for all configured languages
