let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

augroup python_settings
	  autocmd!
	autocmd BufEnter *.py set nospell
augroup END
