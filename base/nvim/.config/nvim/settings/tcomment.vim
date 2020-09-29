if has('macunix')
	vnoremap <D-/> :TComment<cr>
else
	vnoremap <C-/> :TComment<cr>
endif

nnoremap <C-/> :TComment<cr>
if has('macunix')
	nnoremap <D-/> :TComment<cr>
endif
