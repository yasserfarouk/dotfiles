
if executable('ag')
	let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g" '
	set grepprg=ag\ --nogroup\ --nocolor
endif
