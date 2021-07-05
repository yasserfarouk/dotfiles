let g:ctrlsf_backend = "rg"
" nmap     <leader>r <Plug>CtrlSFPrompt
vmap     <leader>r <Plug>CtrlSFVwordPath
vmap     <leader>R <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
