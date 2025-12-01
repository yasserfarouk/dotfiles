# Neovim Configuration Usage Notes

## FZF-Lua Quickfix Integration

### Sending Search Results to Quickfix

When using FZF-Lua searches (e.g., `<leader>st` for live grep):

- **Send ALL results to quickfix**: Press `Ctrl-Q` or `Alt-Q`
- **Send SELECTED results to quickfix**: 
  1. Select items with `Tab` to mark them
  2. Press `Ctrl-Q` or `Alt-Q` to send marked items to quickfix

Once in quickfix, use:
- `:copen` - Open quickfix window
- `:cnext` / `:cprev` - Navigate results
- `:cfdo` - Execute command on all quickfix files

## Copilot Keymaps

- `Alt-Enter` - Accept AI suggestion (main accept)
- `Alt-w` - Accept word
- `Alt-j` - Accept line
- `Alt-]` - Next suggestion
- `Alt-[` - Previous suggestion
- `Ctrl-]` - Dismiss suggestion

## Oil.nvim File Explorer

- `-` - Open Oil file browser in parent directory
- In Oil:
  - `Enter` - Open file/directory
  - `Ctrl-s` - Split vertically
  - `Ctrl-h` - Split horizontally
  - `g.` - Toggle hidden files
  - `Ctrl-r` - Refresh

## LSP Features

All standard LSP features are available via native keymaps:
- `gd` - Go to definition (FZF-Lua picker)
- `gu` - Find references (FZF-Lua picker)
- `gD` - Go to declaration
- `gI` - Go to implementation
- `gy` - Go to type definition
- `K` - Hover documentation
- `gK` - Signature help
- `<F2>` - Rename symbol
- `<leader>ca` - Code action
- `<leader>cf` - Format document
- `[d` / `]d` - Previous/next diagnostic
- `[e` / `]e` - Previous/next error

## VimTeX Features

VimTeX is optimized for speed with continuous compilation:
- Files compile automatically on save
- LuaLaTeX engine (faster than pdflatex)
- Build artifacts in separate `build/` directory
- Forward search with Skim (on macOS)
- Requires: `neovim-remote` (nvr) - already installed at `/Users/yasser/.local/bin/nvr`

## Testing

Two testing frameworks are available:

**Neotest** (modern, UI-rich):
- `<leader>tt` - Test nearest
- `<leader>tf` - Test file
- `<leader>ts` - Test summary
- `<leader>to` - Test output

**vim-test** (classic, compatible):
- `<leader>tn` - Test nearest (vim-test)
- `<leader>tF` - Test file (vim-test)
- `<leader>tS` - Test suite
- `<leader>tl` - Test last
- `<leader>tv` - Visit test

## Terminal Integration

Modern CLI tools available via ToggleTerm:
- `<leader>xg` - LazyGit (modern git TUI)
- `<leader>xd` - LazyDocker (docker TUI)
- `<leader>xh` - Htop/Btop (system monitor)
- `<leader>xp` - Python/IPython REPL
- `<leader>xl` - Lua REPL
- `<leader>xx` - Floating terminal
- `<leader>x-` - Bottom terminal
- `<leader>x\` - Right-side terminal

## Snippet System

Using LuaSnip with friendly-snippets:
- `Tab` - Expand snippet or jump to next placeholder
- `Shift-Tab` - Jump to previous placeholder

## Completion (Blink.cmp)

- `Ctrl-Space` - Manually trigger completion
- `Enter` - Accept completion
- `Ctrl-e` - Close completion menu
- `Tab` / `Shift-Tab` - Navigate completions
- `Ctrl-n` / `Ctrl-p` - Navigate completions (alternate)
- `Ctrl-f` / `Ctrl-b` - Scroll documentation

## LSP Progress Indicator

- Fidget.nvim shows LSP server status in the bottom-right corner
- Automatically appears when LSP servers are initializing or indexing

## File Navigation

- Oil.nvim on `-` for quick file browsing
- Yazi file manager: `<leader>xf` (if yazi is installed)
