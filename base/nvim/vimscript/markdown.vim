function SetupMarkdown()
	let g:table_mode_corner="|"
	let g:markdown_fold_override_foldtext = 0
	let g:markdown_syntax_conceal = 0
	" let g:neomake_markdown_proselint_maker = {
	" 			\ 'errorformat': '%W%f:%l:%c: %m',
	" 			\ 'postprocess': function('neomake#postprocess#GenericLengthPostprocess'),
	" 			\}
	" let g:neomake_markdown_enabled_makers = ['alex', 'proselint']
	" let g:neoformat_markdown_prettier = g:standard_prettier_settings
	" let g:neoformat_enabled_markdown = ['prettier']
endfunction

augroup Markdown
	autocmd!
	autocmd FileType markdown call SetupMarkdown()
augroup END
