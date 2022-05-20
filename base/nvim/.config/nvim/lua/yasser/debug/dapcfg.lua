vim.fn.sign_define('DapBreakpoint',
                   {text = "🔸", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = "💀", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define('DapLogPoint',
                   {text = "📚", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define('DapStopped',
                   {text = "🟢", texthl = "", linehl = "", numhl = ""})
vim.cmd([[
nnoremap <silent> <F3> :DebugScopes<CR>
nnoremap <silent> <F4> :DebugHover<CR>
nnoremap <silent> <S-F4> :DebugVHover<CR>
nnoremap <silent> <F5> :DebugContinue<CR>
nnoremap <silent> <S-F5> :DebugLast<CR>
nnoremap <silent> <C-F5> :DebugPause<CR>
nnoremap <silent> <F6> :DebugToggleRepl<CR>
nnoremap <silent> <F7> :DebugUp<CR>
nnoremap <silent> <F8> :DebugDown<CR>
nnoremap <silent> <A-F8> :DebugSetExceptionBreakpointsDefault<CR>
nnoremap <silent> <S-F8> :DebugSetExceptionBreakpointsRaised<CR>
nnoremap <silent> <C-F8> :DebugSetExceptionBreakpointsUncaught<CR>
nnoremap <silent> <F9> :DebugToggleBreakpoint<CR>
nnoremap <silent> <A-F9> :DebugLogPoint<CR>
nnoremap <silent> <S-F9> :DebugConditionalBreakpoint<CR>
nnoremap <silent> <C-F9> :DebugListBreakpoints<CR>
nnoremap <silent> <F10> :DebugStepOver<CR>
nnoremap <silent> <F11> :DebugStepInto<CR>
nnoremap <silent> <S-F11> :DebugStepOut<CR>
nnoremap <silent> <F12> :DebugStop<CR>
nnoremap <silent> <F12> :DebugStop<CR>
]])
require('dap.ext.vscode').load_launchjs()
