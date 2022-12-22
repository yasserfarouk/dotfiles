command! BufOnly silent! execute "%bd|e#|bd#"
command! LspCodeAction lua vim.lsp.buf.code_action()
command! LspDeclaration lua vim.lsp.buf.declaration()
command! LspDefinition lua vim.lsp.buf.definition()
command! LspDocumentSymbol lua vim.lsp.buf.document_symbol()
command! LspFormatting lua vim.lsp.buf.format()
command! LspFormattingSync lua vim.lsp.buf.format_sync()
command! LspHover lua vim.lsp.buf.hover()
command! LspImplementation lua vim.lsp.buf.implementation()
command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()
command! LspRangeFormatting lua vim.lsp.buf.range_formatting()
command! LspReferences lua vim.lsp.buf.references()
command! LspRename lua vim.lsp.buf.rename()
command! LspTypeDefinition lua vim.lsp.buf.type_definition()
command! LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()
command! LspGotoNext lua vim.lsp.buf.goto_next()
command! LspGotoPrev lua vim.lsp.buf.goto_prev()
command! LspShowLineDiagnostics lua vim.lsp.buf.show_line_diagnostics()
command! NextHunk lua vim.lsp.buf.next_hunk()
command! PrevHunk lua vim.lsp.buf.prev_hunk()
command! StageHunk lua vim.lsp.buf.stage_hunk()
command! UndoStageHunk lua vim.lsp.buf.undo_stage_hunk()
command! ResetHunk lua vim.lsp.buf.reset_hunk()
command! ResetBuffer lua vim.lsp.buf.reset_buffer()
command! PreviewHunk lua vim.lsp.buf.preview_hunk()
command! BlameLine lua vim.lsp.buf.blame_line()
command! W noa w

" Debugging
command! DebugToggleBreakpoint lua require'dap'.toggle_breakpoint()
command! DebugStart lua require'dap'.continue()
command! DebugContinue lua require'dap'.continue()
command! DebugStepOver lua require'dap'.step_over()
command! DebugStepOut lua require'dap'.step_out()
command! DebugStop lua require'dap'.close()
command! DebugStepInto lua require'dap'.step_into()
command! DebugToggleRepl lua require'dap'.repl.toggle()
command! DebugGetSession lua require'dap'.session()
command! DebugConditionalBreakpoint lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
command! DebugLogPoint lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
command! DebugLast lua require'dap'.run_last()<CR>
command! DebugUp lua require'dap'.up()<CR>
command! DebugDown lua require'dap'.down()<CR>
command! DebugGoto lua require'dap'.goto_()<CR>
command! DebugGotoLine lua require'dap'.goto_(vim.fn.input("Line Number: "))<CR>
command! DebugListBreakpoints lua require'dap'.list_breakpoints()<CR>
command! DebugSetExceptionBreakpointsDefault lua require'dap'.set_exception_breakpoints("default")<CR>
command! DebugSetExceptionBreakpointsNone lua require'dap'.set_exception_breakpoints({})<CR>
command! DebugSetExceptionBreakpointsUncaught lua require'dap'.set_exception_breakpoints({"uncaught"})<CR>
command! DebugSetExceptionBreakpointsRaised lua require'dap'.set_exception_breakpoints({"uncaught", "raised"})<CR>
command! DebugPause lua require'dap'.pause(vim.fn.inpu("Thread ID: "))<CR>
command! DebugHover lua require'dap.ui.widgets'.hover()<CR>
command! DebugScopes lua require'dap.ui.widgets'.scopes()<CR>
command! DebugVHover lua require'dap.ui.widgets'.visual_hover()<CR>
command! DebugHoverToggleMultiline lua require'dap.ui.widgets'.toggle_multiline_display()<CR>


" telescope
command! TelescopeVim lua require("yasser.search.telescope.vimrc").search_vimfiles()
command! TelescopeConfig lua require("yasser.search.telescope.configs").search_vimfiles()
command! TelescopeEmoji lua require("telescope.builtin").symbols{sources={"emoji", "kaomoji"}}
command! TelescopeLatex lua require("telescope.builtin").symbols{sources={"latex", "math"}}
command! TelescopeWord lua require("telescope.builtin").grep_string{search = vim.fn.expand("<cword>")}
command! TelescopeHelp lua require("telescope.builtin").help_tags()

" Available Debug Adapters:
"   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
" 
" Adapter configuration and installation instructions:
"   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
" 
" Debug Adapter protocol:
"   https://microsoft.github.io/debug-adapter-protocol/

" TODO Add full support later
" nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
" nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
" nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
" nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
" nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

autocmd! User GoyoEnter lua require('gitsigns').toggle_signs()
autocmd! User GoyoLeave lua require('gitsigns').toggle_signs()

autocmd User GoyoEnter set laststatus=0 
autocmd User GoyoLeave set laststatus=2

" autocmd! User GoyoEnter lua require('galaxyline').disable_galaxyline()
" autocmd! User GoyoLeave lua require('galaxyline').galaxyline_augroup()
