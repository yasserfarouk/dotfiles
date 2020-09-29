
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction



function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


let g:coc_snippet_next = '<tab>'


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function SetCocShortcuts()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? coc#_select_confirm() :
				\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	if has('patch8.1.1068')
		" Use `complete_info` if your (Neo)Vim version supports it.
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [G <Plug>(coc-diagnostic-first)
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	nmap <silent> ]G <Plug>(coc-diagnostic-last)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	" nmap <silent> <S-F7> <Plug>(coc-references)
	nmap <silent> gu <Plug>(coc-references)
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	" Symbol renaming.
	nmap <F2> <Plug>(coc-rename)
	nnoremap <leader>cr <Plug>(coc-rename)

	" Formatting selected code.
	xmap <localleader>cf  <Plug>(coc-format-selected)
	nmap <localleader>cf  <Plug>(coc-format-selected)

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <localleader>a  <Plug>(coc-codeaction-selected)
	nmap <localleader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current line.
	nmap <localleader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <localleader>qf  <Plug>(coc-fix-current)

	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)
	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <localleader>ca  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent> <localleader>ce  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent> <localleader>cc  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent> <localleader>co  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent> <localleader>cs  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <localleader>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <localleader>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent> <localleader>cp  :<C-u>CocListResume<CR>"
	" Use <TAB> for selections ranges.
	" NOTE: Requires 'textDocument/selectionRange' support from the language server.
	" coc-tsserver, coc-python are the examples of servers that support it.
	" nmap <silent> <TAB> <Plug>(coc-range-select)
	" xmap <silent> <TAB> <Plug>(coc-range-select)
endfunction

augroup COC
	autocmd!
	autocmd FileType * call SetCocShortcuts()
augroup END
