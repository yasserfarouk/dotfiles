"  session management ----------------------------------------------------{{{
if has('nvim')
	let g:session_directory = "~/.local/nvim/yasser/session"
else
	let g:session_directory = "~/.local/nvim/yasser/session"
endif

let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 0
let g:auto_save = 0
let g:auto_save_no_updatetime = 1
let g:auto_save_silent = 0
let g:auto_save_postsave_hook = 'TagsGenerate'

" }}}
