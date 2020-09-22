
" Normal mapping ----------------------------------------------------------{{{
" nnoremap ; :
nnoremap <silent>== ggVG=
nnoremap <silent> <leader>rws :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s<CR><Esc><C-o>
nmap <leader>mt <plug>(MergetoolToggle)
nnoremap <leader>TM :TableModeToggle<CR>

nnoremap <leader>q :wq<CR>
" Float Term
nnoremap <leader>xh :FloatermNew<CR>
nnoremap <leader>xx :FloatermToggle<CR>
nnoremap <leader>xf :FloatermNew vifm<CR>
nnoremap <leader>xt :FloatermNew ytop<CR>
nnoremap <leader>xG :FloatermNew lazygit<CR>
nnoremap <leader>xP :FloatermNew ipython<CR>
nnoremap <leader>xb :call <SID>run_black()<CR>
nnoremap <leader>xi :call <SID>run_isort()<CR>
nnoremap <leader>xB :call <SID>run_black_dir()<CR>
nnorema <leader>xg :FloatermNew googler
nnoremap <leader>xn :FloatermNext<CR>
nnoremap <leader>xp :FloatermPrev<CR>

"  terminal emulation
nnoremap <silent> <leader>term :terminal<CR>
nnoremap <silent> <leader>shr :FloatermNew --wintype=normal --position=right<CR>
nnoremap <silent> <leader>shb :FloatermNew --wintype=normal --height=0.3 --position=bottom<CR>
nnoremap <silent> <leader>shl :FloatermNew --wintype=normal --position=left<CR>
nnoremap <silent> <leader>sht :FloatermNew --wintype=normal --position=top<CR>
nnoremap <silent> <leader>run :FloatermSend<CR>

" toggle workspace
nnoremap <silent> <leader>se :ToggleWorkspace<CR>
nnoremap <silent> <leader>ch :CloseHiddenBuffers<CR>

" Basic file system commands
nnoremap <M-n> :!touch<Space>
nnoremap <M-d> :!mkdir<Space>
nnoremap <M-m> :!mv<Space>%<Space>
nnoremap <leader><leader>b :call SetBackground()<CR>
noremap <F12> :call GoHighlight()<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" replace.vim mappings
" nmap R <Plug>ReplaceOperator
" vmap R <Plug>ReplaceOperator
" nmap S <Plug>ReplaceOperator
" nmap X <Plug>ExchangeOperator

" multi-cursoer mappings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" vim-test mappings
nmap <silent> <localleader>tn :TestNearest<CR>
nmap <silent> <localleader>tf :TestFile<CR>
nmap <silent> <localleader>ts :TestSuite<CR>
nmap <silent> <localleader>tl :TestLast<CR>
nmap <silent> <localleader>tv :TestVisit<CR>


nnoremap \ za

noremap  <silent> <Home> g<Home>
noremap  <silent> <End>  g<End>

" copy to end using Y because we cut to end with D
" nnoremap <A-O> <S-O><Esc>j
nnoremap Y y$

nnoremap <leader><leader>vim :vs $MYVIMRC<CR>

if !exists('g:vscode')
"  function keys
	nnoremap <leader>tt :TagbarToggle<CR>

	let g:UltiSnipsExpandTrigger="<C-p>"
	let g:UltiSnipsJumpForwardTrigger="<C-p>"
	let g:UltiSnipsJumpBackwardTrigger="<C-n>"

	set pastetoggle=<F6>
endif

"  Navigate between display lines
nnoremap <silent><expr>k      v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr>j      v:count == 0 ? 'gj' : 'j'
nnoremap <silent><expr><Up>   v:count == 0 ? 'gk' : 'k'
nnoremap <silent><expr><Down> v:count == 0 ? 'gj' : 'j'

"  copy current file path to clipboard
nnoremap <leader>cp :let @+= expand("%") <cr>

"  Search mappings: These will make it so that going to the next one in a
"  search will center on the line it is found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"  removing search highlighting using <esc>
nnoremap <silent> <esc> :noh<cr>

"  a map to delete to the blackhole _ register (no cutting)
nnoremap <leader>d "_d
nnoremap <leader>D "_D

"  Align blocks of text and keep them selected
" nnoremap <leader>a :call <SID>SynStack()<CR>

"  Space to toggle folds.
nnoremap \ za

if !exists('g:vscode')
"  Opens an edit command with the path of the currently edited file filled in
	noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>

"  FZF shortcuts
	nnoremap <silent> <leader>b :Buffers<CR>
	nnoremap <silent> <leader>c :Commands<CR>
	nnoremap <silent> <leader>f :Files<CR>
endif

" setting working directory
nnoremap <leader>cd :cd %:p:h<cr>

" Buffer management
nnoremap <leader>bd :bd<CR>
nmap <leader>. :bnext<CR>
nmap <leader>, :bprevious<CR>

" comment
nnoremap <C-/> :TComment<cr>
if has('macunix')
	nnoremap <D-/> :TComment<cr>
endif

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

nmap     <leader>r <Plug>CtrlSFPrompt
vmap     <leader>r <Plug>CtrlSFVwordPath
vmap     <leader>R <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


noremap <silent> <Up>    :wincmd k<CR>
noremap <silent> <Down>  :wincmd j<CR>
noremap <silent> <Left>  :wincmd h<CR>
noremap <silent> <Right> :wincmd l<CR>
noremap <silent> <c-k>    :wincmd k<CR>
noremap <silent> <c-j>  :wincmd j<CR>
noremap <silent> <c-h>  :wincmd h<CR>
noremap <silent> <c-l> :wincmd l<CR>

noremap <silent> <C-s> :wincmd s<CR>
noremap <silent> <C-\> :wincmd v<CR>
" Use 'H' and 'L' keys to move to start/end of the line
" noremap H ^
" noremap L $

" Recenter when jump back and forward
nnoremap <C-o> <C-o>zz
nnoremap <C-l> <C-i>zz

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
nnoremap <silent> <leader>k :bd!<CR>
if has('macunix')
	" Open current directory in Finder
	nnoremap <leader>o :silent exec "!open %:p:h" \| redraw!<CR>
endif

function! GoogleSearch()
     let searchterm = getreg("g")
     silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>g "gy<Esc>:call GoogleSearch()<CR>

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }
 
" Close all readonly buffers with just a "q" keystroke, otherwise "q" is used to record macros in a normal mode
nnoremap  <expr> q &readonly ? ":quit\<CR>" : "q"

" Save and quit
nnoremap <silent> <leader>w :wall<CR>
" nnoremap ZZ :update! \| QuitWindow<CR>

" Save and quit for multiple buffers
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
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

" Split management
inoremap <C-h> <ESC><C-w>h
inoremap <C-j> <ESC><C-w>j
inoremap <C-k> <ESC><C-w>k
inoremap <C-l> <ESC><C-w>l

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

" vmap R <Plug>ReplaceOperator
vnoremap <S-Down> j
vnoremap <S-Up> k
vnoremap <S-Left> h
vnoremap <S-Right> l

vmap < <gv
vmap > >gv
vnoremap <leader>d "_d
if has('macunix')
	vnoremap <D-/> :TComment<cr>
else
	vnoremap <C-/> :TComment<cr>
endif
vnoremap <leader>ga <Plug>(EasyAlign)
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
vnoremap y myy`y
vnoremap Y myY`y
vnoremap // y/<C-R>"<CR>

"  Space to toggle folds.
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
cnoremap <A-j> :call split_line_text_at_cursor()<CR>

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

