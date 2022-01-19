command! LspCodeAction lua require 'utils.nv_utils'.code_action()
command! LspDeclaration lua require 'utils.nv_utils'.declaration()
command! LspDefinition lua require 'utils.nv_utils'.definition()
command! LspDocumentSymbol lua require 'utils.nv_utils'.document_symbol()
command! LspFormatting lua require 'utils.nv_utils'.formatting()
command! LspFormattingSync lua require 'utils.nv_utils'.formatting_sync()
command! LspHover lua require 'utils.nv_utils'.hover()
command! LspImplementation lua require 'utils.nv_utils'.implementation()
command! LspRangeCodeAction lua require 'utils.nv_utils'.range_code_action()
command! LspRangeFormatting lua require 'utils.nv_utils'.range_formatting()
command! LspReferences lua require 'utils.nv_utils'.references()
command! LspRename lua require 'utils.nv_utils'.rename()
command! LspTypeDefinition lua require 'utils.nv_utils'.type_definition()
command! LspWorkspaceSymbol lua require 'utils.nv_utils'.workspace_symbol()
command! LspGotoNext lua require 'utils.nv_utils'.goto_next()
command! LspGotoPrev lua require 'utils.nv_utils'.goto_prev()
command! LspShowLineDiagnostics lua require 'utils.nv_utils'.show_line_diagnostics()
command! NextHunk lua require 'utils.nv_utils'.next_hunk()
command! PrevHunk lua require 'utils.nv_utils'.prev_hunk()
command! StageHunk lua require 'utils.nv_utils'.stage_hunk()
command! UndoStageHunk lua require 'utils.nv_utils'.undo_stage_hunk()
command! ResetHunk lua require 'utils.nv_utils'.reset_hunk()
command! ResetBuffer lua require 'utils.nv_utils'.reset_buffer()
command! PreviewHunk lua require 'utils.nv_utils'.preview_hunk()
command! BlameLine lua require 'utils.nv_utils'.blame_line()
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
