function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction


function! GoHighlight()
	syntax on
	syntax sync fromstart
endfunction!

function! PandocPDF()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=12pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction!
function! PandocPDFLandscape()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=12pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction!

if !exists('*s:setupWrapping')
	function s:setupWrapping()
		set wrap
		set wm=2
		set textwidth=79
	endfunction
endif

function! SetBackground()
	if &background == 'dark'
		execute "set background=light"
	else
		execute "set background=dark"
	endif
endfunction
" Normal mapping ----------------------------------------------------------{{{
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <silent>== ggVG=<c-o>

" correct last spelling error
inoremap <c-s> <esc>[s1z=`]a
" Basic file system commands
inoremap <F12> <C-o>:syntax sync fromstart<CR>

nnoremap \ za
nnoremap <s-\> zO

noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

" copy to end using Y because we cut to end with D
" nnoremap <A-O> <S-O><Esc>j
nnoremap Y y$

if !exists('g:vscode')
"  function keys
	set pastetoggle=<F6>
endif

"  Navigate between display lines
nnoremap <silent><expr>k      v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr>j      v:count == 0 ? 'gj' : 'j'
nnoremap <silent><expr><Up>   v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr><Down> v:count == 0 ? 'gj' : 'j'

"  Search mappings: These will make it so that going to the next one in a
"  search will center on the line it is found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"  removing search highlighting using <esc>
nnoremap <silent> <esc> :noh<cr>

" if !exists('g:vscode')
" "  Opens an edit command with the path of the currently edited file filled in
" 	noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>
" endif

" " setting working directory
" nnoremap <leader>cd :cd %:p:h<cr>

" " Buffer management
" nnoremap <leader>bd :bd<CR>

" comment

" allow shift arrows to copy
nnoremap <S-Down> vj
nnoremap <S-Up> vk
nnoremap <S-Left> vh
nnoremap <S-Right> vl

" insert from mac keyboard in normal mode
if has('macunix')
" pbcopy for OSX copy/paste
	nmap <D-v> :r !pbpaste<cr>
endif

noremap <silent> <Up>    :wincmd k<CR>
noremap <silent> <Down>  :wincmd j<CR>
noremap <silent> <Left>  :wincmd h<CR>
noremap <silent> <Right> :wincmd l<CR>
" noremap <silent> <leader><leader>o :wincmd o<CR>
" noremap <silent> <c-k>    :wincmd k<CR>
" noremap <silent> <c-j>  :wincmd j<CR>
" noremap <silent> <c-h>  :wincmd h<CR>
" noremap <silent> <c-l> :wincmd l<CR>

noremap <silent> <C-s> :wincmd s<CR>
noremap <silent> <C-\> :wincmd v<CR>
" Use 'H' and 'L' keys to move to start/end of the line
" noremap H ^
" noremap L $

" Recenter when jump back and forward
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" z+, moves next line below the window
" z-, moves next line above the window
nnoremap z- z^

" Tag matching list
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [t :tprev<CR>
nnoremap <silent> ]T :tlast<CR>
nnoremap <silent> [T :tfirst<CR>

" Tags in preview window
nnoremap <silent> ]p :ptnext<CR>
nnoremap <silent> [p :ptprev<CR>
nnoremap <silent> ]P :ptlast<CR>
nnoremap <silent> [P :ptfirst<CR>

" Center screen after navigation shortcuts
nnoremap } }zvzz
nnoremap { {zvzz

nnoremap ]] ]]zvzz
nnoremap [[ [[zvzz
nnoremap [] []zvzz
nnoremap ][ ][zvzz
" Drop into insert mode on Backspace
nnoremap <BS> i<BS>
" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>z zMzvzz
" Kill buffer


vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>
" Close all readonly buffers with just a "q" keystroke, otherwise "q" is used to record macros in a normal mode
nnoremap  <expr> q &readonly ? ":quit\<CR>" : "q"

" Save and quit

" Save and quit for multiple buffers
" nnoremap <silent> <leader>W :wall<CR>
" nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> ZX :confirm xall<CR>
" Terminal mappings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif
if has('nvim')
  " Terminal mode:
  tnoremap <C-h> <c-\><c-n><c-w>h
  tnoremap <C-j> <c-\><c-n><c-w>j
  tnoremap <C-k> <c-\><c-n><c-w>k
  tnoremap <C-l> <c-\><c-n><c-w>l
endif
" Insert mapping ----------------------------------------------------------{{{
"  duplicate a line
" Shift-Enter to start editing new line without splitting the current one
inoremap <S-CR> <C-o>o
inoremap <C-d> <Esc>yyPji

"  Get out of insert mode using jk or jj
inoremap jk <Esc>
" inoremap jj <Esc>

"  Navigate between display lines
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

"  insert mode
" inoremap <C-a> <C-o>:call <SID>home()<CR>
inoremap <C-e> <End>
inoremap <M-Left> <C-o>ba
inoremap <M-Right> <C-o>wa

" " Split management
" inoremap <C-h> <ESC><C-w>h
" inoremap <C-j> <ESC><C-w>j
" inoremap <C-k> <ESC><C-w>k
" inoremap <C-l> <ESC><C-w>l

if has('macunix')
	inoremap <D-c> <Esc>yy
	inoremap <D-v> <Esc>Pa
endif

" ALlow shift-arrows to be used for selection
inoremap <S-Down> <Esc>lvj
inoremap <S-Up> <Esc>lvk
inoremap <S-Left> <Esc>lvh
inoremap <S-Right> <Esc>lvl

" }}}

" Visual mapping ----------------------------------------------------------{{{

vmap gr <Plug>ReplaceOperator
vmap gx <Plug>ReplaceOperator
vnoremap <S-Down> j
vnoremap <S-Up> k
vnoremap <S-Left> h
vnoremap <S-Right> l

vmap < <gv
vmap > >gv
vnoremap <leader>d "_d
" vnoremap <leader>ga <Plug>(EasyAlign)
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
vnoremap y myy`y
vnoremap Y myY`y
vnoremap // y/<C-R>"<CR>

"  Backslash to toggle folds.
vnoremap \ za

if has('macunix')
" pbcopy for OSX copy/paste
	vmap <D-v> :r !pbpaste<CR>
	vmap <D-c> :w !pbcopy<CR><CR>
endif

"  Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"  Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }}}

"  C mappings -----------------------------------------------------------{{{
"  Basic cursor movement and deletion keybindings from emacs, for vim.
"  command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
" cnoremap <A-j> :call split_line_text_at_cursor()<CR>

"  no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
"  cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>


"  allow saving to protected file using sudo without leaving vim
cmap w!! w !sudo tee % >/dev/null
" }}}
" nnoremap <leader>pdf :call PandocPDF()<cr>
" Better nav for omnicomplete TODO figure out why this is being overridden
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")


nnoremap gx :call OpenURLUnderCursor()<CR>
