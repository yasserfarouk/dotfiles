let g:vimspector_enable_mappings = 'HUMAN'
" nnoremap <localleader>dc <Plug>VimspectorContinue
" nnoremap <localleader>dC <Plug>VimspectorStop
" nnoremap <localleader>dr <Plug>VimspectorRestart
" nnoremap <localleader>dp <Plug>VimspectorPause
" nnoremap <localleader>db <Plug>VimspectorToggleBreakpoint
" nnoremap <localleader>dB <Plug>VimspectorToggleConditionalBreakpoint
" nnoremap <localleader>df <Plug>VimspectorAddFunctionBreakpoint
" nnoremap <localleader>dn <Plug>VimspectorStepOver
" nnoremap <localleader>ds <Plug>VimspectorStepInto
" nnoremap <localleader>du <Plug>VimspectorStepOut
nnoremap <localleader>dd :call vimspector#Launch()<CR>
nnoremap <localleader>dx :VimspectorReset<CR>
nnoremap <localleader>de :VimspectorEval<space>
nnoremap <localleader>dw :VimspectorWatch<space>
nnoremap <localleader>do :VimspectorShowOutput<space>
nnoremap <localleader>dr :VimspectorRestart<cr>
" autocmd FileType java nmap <localleader>dd :CocCommand java.debug.vimspector.start<CR>
"
" nnoremap <F5> <Plug>VimspectorContinue
" nnoremap <S-F5> <Plug>VimspectorStop
" nnoremap <C-F5> <Plug>VimspectorRestart
" nnoremap <F4> <Plug>VimspectorPause
" nnoremap <F9> <Plug>VimspectorToggleBreakpoint
" nnoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
" nnoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
" nnoremap <F8> <Plug>VimspectorStepOver
" nnoremap <F7> <Plug>VimspectorStepInto
" nnoremap <S-F8> <Plug>VimspectorStepOut
" inoremap <F5> <Plug>VimspectorContinue
" inoremap <S-F5> <Plug>VimspectorStop
" inoremap <C-F5> <Plug>VimspectorRestart
" inoremap <F4> <Plug>VimspectorPause
" inoremap <F9> <Plug>VimspectorToggleBreakpoint
" inoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
" inoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
" inoremap <F8> <Plug>VimspectorStepOver
" inoremap <F7> <Plug>VimspectorStepInto
" inoremap <S-F8> <Plug>VimspectorStepOut
