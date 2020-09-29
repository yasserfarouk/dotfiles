
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }
 
nnoremap <silent>K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent><F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent><F8> :call LanguageClient_contextMenu()<CR>
nnoremap <silent><F7> :call LanguageClient#textDocument_references()<CR>

function SetLSPShortcuts()
  nnoremap gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <F7> :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <S-k> :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
  autocmd FileType python call SetLSPShortcuts()
augroup END
