

function! MyFoldText()
	let line = getline(v:foldstart)
	let nucolwidth = &fdc + &number * &numberwidth
	let windowwidth = winwidth(0) - nucolwidth - 3
	let foldedlinecount = v:foldend - v:foldstart

	" expand tabs into spaces
	let onetab = strpart('          ', 0, &tabstop)
	let line = substitute(line, '\t', onetab, 'g')

	let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
	" let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
	" let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
	let fillcharcount = windowwidth - len(line)
	" return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
	return line . '⋯'. repeat(" ",fillcharcount)
endfunction

function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! s:home()
	let start_col = col('.')
	normal! ^
	if col('.') == start_col
		normal! 0
	endif
	return ''
endfunction

function! s:kill_line()
	let [text_before_cursor, text_after_cursor] = s:split_line_text_at_cursor()
	if len(text_after_cursor) == 0
		normal! J
	else
		call setline(line('.'), text_before_cursor)
	endif
	return ''
endfunction

function! s:split_line_text_at_cursor()
	let line_text = getline(line('.'))
	let text_after_cursor  = line_text[col('.')-1 :]
	let text_before_cursor = (col('.') > 1) ? line_text[: col('.')-2] : ''
	return [text_before_cursor, text_after_cursor]
endfunction

function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr()) "we havent moved
		if (match(a:key,'[jk]')) "were we going up/down
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction
