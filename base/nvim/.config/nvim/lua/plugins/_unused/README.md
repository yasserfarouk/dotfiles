# Unused Plugin Configurations

This folder contains plugin configurations that have been removed from the active Neovim setup but preserved for future reference.

## Removed Plugins (2025-10-28)

These plugins were removed as part of the optimization effort described in `NEOVIM_OPTIMIZATION_REPORT.md`:

### Duplicate Search/Replace Tools
- **far.lua** - Far.vim search and replace (replaced by grug-far.nvim)
- **spectre.lua** - nvim-spectre search and replace (replaced by grug-far.nvim)

### AI Assistants
- **gemini.lua** - Gemini AI integration (keeping copilot.lua instead)

### Database Tools
- **dbee.lua** - Database client (heavy, 15ms startup impact)

### Other Tools
- **chatgpt.lua** - ChatGPT integration (was already commented out)
- **csv.lua** - CSV tools configuration
- **dash.lua** - Dash documentation integration (was already disabled)
- **sniprun.lua** - Code execution tool

## How to Re-enable

To re-enable any of these plugins:

1. Move the file back to `lua/plugins/`
2. The plugin will be automatically loaded by lazy.nvim
3. Run `:Lazy sync` to install the plugin
4. Restart Neovim

## Note

These configurations may need updates if re-enabled, as plugin APIs may have changed since they were last used.
