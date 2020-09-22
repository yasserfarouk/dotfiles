
" Vimspector -------------{{{
nnoremap <F5> <Plug>VimspectorContinue
nnoremap <S-F5> <Plug>VimspectorStop
nnoremap <C-F5> <Plug>VimspectorRestart
nnoremap <F4> <Plug>VimspectorPause
nnoremap <F9> <Plug>VimspectorToggleBreakpoint
nnoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
nnoremap <F8> <Plug>VimspectorStepOver
nnoremap <F7> <Plug>VimspectorStepInto
nnoremap <S-F8> <Plug>VimspectorStepOut
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dx :VimspectorReset<CR>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>

inoremap <F5> <Plug>VimspectorContinue
inoremap <S-F5> <Plug>VimspectorStop
inoremap <C-F5> <Plug>VimspectorRestart
inoremap <F4> <Plug>VimspectorPause
inoremap <F9> <Plug>VimspectorToggleBreakpoint
inoremap <S-F9> <Plug>VimspectorToggleConditionalBreakpoint
inoremap <C-F9> <Plug>VimspectorAddFunctionBreakpoint
inoremap <F8> <Plug>VimspectorStepOver
inoremap <F7> <Plug>VimspectorStepInto
inoremap <S-F8> <Plug>VimspectorStepOut
" }}}
