function SetupMarkdown()
	let g:table_mode_corner="|"
	let g:markdown_fold_override_foldtext = 0
	let g:markdown_syntax_conceal = 0
endfunction

augroup Markdown
	autocmd!
	autocmd FileType markdown call SetupMarkdown()
augroup END
