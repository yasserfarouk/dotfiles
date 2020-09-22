function SetupHtml()
	let g:neomake_html_enabled_makers = []
	let g:neoformat_enabled_html = ['htmlbeautify']
	" For conceal markers.
	if has('conceal')
		set conceallevel=2 concealcursor=niv
	endif
endfunction

augroup Html
	autocmd!
	autocmd FileType htm, html, php call SetupHtml()
augroup END
