" Leader Key Maps

" helper functions
function! GoogleSearch()
	let searchterm = getreg("g")
	silent! exec "!chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction

function! PandocPDF()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=12pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction

function! PandocHTML()
	silent exec "Dispatch pandoc  -o " . expand("%:r"). ".html -s " . expand("%") . "; open " . expand("%:r") . ".html"
endfunction

function! PublishMedium()
	silent exec "Dispatch pandoc  -o " . expand("%:r"). ".html -s " . expand("%") . "; ~/go/bin/md-publisher publish --medium-token `cat $HOME/bin/.medium_token` " . expand("%:r") . ".html"

endfunction

function! PandocPDFLandscape()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=12pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction

function! SetupWrapping()
	if &wrap == 1
		set nowrap
	else
		set wrap
		set wm=2
		set textwidth=79
	endif
endfunction

function! SetBackground()
	if &background == 'dark'
		" if &colors != 'gruvbox'
		" 	execute "set colors=gruvbox"
		" endif
		execute "set background=light"
	else
		execute "set background=dark"
	endif
endfunction

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆', " ": 'SPC'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['/'] = 'comment toggle'
let g:which_key_map[';'] = [ ':Dashboard'                                      , 'home screen' ]
let g:which_key_map['?'] = [ ':NvimTreeFindFile'                               , 'find current file' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'                                 , 'explorer' ]
let g:which_key_map['f'] = [ ':Telescope find_files'                           , 'find files' ]
let g:which_key_map['F'] = [ ':Telescope file_browser'                           , 'file browser' ]
let g:which_key_map['h'] = [ ':let @/ = ""'                                    , 'no highlight' ]
let g:which_key_map['w'] = [ ':wa'                                             , 'save all' ]
let g:which_key_map['q'] = [ '<C-W>c'                                  , 'quit window' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'                                   , 'ranger' ]
let g:which_key_map['-'] = [ '<C-W>s'                             , 'split below']
let g:which_key_map['\'] = [ '<C-W>v'                             , 'split right']
let g:which_key_map['='] = [ '<C-W>='                             , 'balance windows' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                    , 'undo tree']
let g:which_key_map['z'] = [ '<C-W>m'                             , 'zoom window']
" TODO create entire treesitter section
let g:which_key_map['v'] = [ '<C-W>v'                                          , 'split right']
" TODO play nice with status line

" Group mappings

" m for markdown
let g:which_key_map.m = {
			\ 'name' : '+markdown',
			\ 'c' : [':call PandocPDF()' , 'compile (portrait)'],
			\ 'h' : [':call PandocHTML()' , 'compile (html)'],
			\ 'P' : [':call PublishMedium()' , 'publish (medium)'],
			\ 'l' : [':call PandocPDFLandscape()' , 'compile (landscape)'],
			\ 'p' : [':MarkdownPreview' , 'preview']
			\}
" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '>' : [':bnext'        , 'next'],
      \ '<' : [':bprevious'    , 'prev'],
      \ '$' : [':blast'    , 'last'],
      \ '^' : [':bfirst'    , 'first'],
      \ 'b' : [':Telescope buffers'                , 'pick buffer'],
      \ 'd' : [':BufferClose'               , 'delete-buffer'],
      \ 'n' : [':bnext'                  , 'next-buffer'],
      \ 'p' : [':bprevious'              , 'previous-buffer'],
	  \ 'o' : [':Bufonly'              , 'close others'],
      \ }

" f is for find and replace
let g:which_key_map.r = {
			\ 'name' : '+find & replace' ,
			\ 'b' : [':Farr --source=vimgrep'    , 'buffer'],
			\ 'p' : [':Farr --source=rgnvim'     , 'project'],
			\ }
" d is for debug
let g:which_key_map.d = {
      \ 'name' : '+debug' ,
      \ 'b' : ['DebugToggleBreakpoint '        , 'toggle breakpoint'],
      \ 'l' : ['DebugStepInto'                 , 'step into'],
      \ 'h' : ['DebugStepOut'                 , 'step out'],
      \ 'j' : ['DebugStepOver'                 , 'step over'],
      \ 'r' : ['DebugToggleRepl'               , 'toggle repl'],
      \ 'g' : ['DebugStart'                    , 'start/continue'],
      \ 'k' : ['DebugHover'     ,'hover'],
      \ 's' : ['DebugScopes'     ,'scopes'],
      \ 'v' : ['DebugVHover'     ,'visual-hover'],
      \ 'z' : ['DebugLast'     ,'last'],
      \ 'p' : ['DebugPause'     ,'pause'],
      \ 'u' : ['DebugUp'     ,'up'],
      \ 'd' : ['DebugDown'     ,'down'],
      \ 'D' : ['DebugSetExceptionBreakpointsDefault'     ,'exceptions-default'],
      \ 'N' : ['DebugSetExceptionBreakpointsNone'     ,'exceptions-none'],
      \ 'R' : ['DebugSetExceptionBreakpointsRaised'     ,'exceptions-raised'],
      \ 'U' : ['DebugSetExceptionBreakpointsUncaught'     ,'exceptions-uncaught'],
      \ 'L' : ['DebugLogPoint'     ,'log'],
      \ 'C' : ['DebugConditionalBreakpoint'     ,'conditional breakpoint'],
      \ }

" d is for debug using vimspector
let g:which_key_map.D = {
			\ 'name' : '+debug (v)' ,
			\ 'd' : [':call vimspector#Launch()<cr>'        , 'launch debugger'],
			\ 'x' : ["<Plug>(VimspectorReset)" , 'reset'],
			\ 'r' : ["<Plug>(VimspectorRestart)", 'restart'],
			\ 'e' : [':VimspectorEval ' , 'eval'],
			\ 'w' : [':VimspectorWatch ' , 'watch'],
			\ 'o' : [':VimspectorShowOutput ' , 'output'],
			\ 'c' : ["<Plug>(VimspectorContinue)", 'continue'],
			\ 'C' : ["<Plug>(VimspectorStop)", 'stop'],
			\ 'p' : ["<Plug>(VimspectorPause)", 'pause'],
			\ 'b' : ["<Plug>(VimspectorToggleBreakpoint)", 'roggle breakpoint'],
			\ 'B' : ["<Plug>(VimspectorToggleConditionalBreakpoint)", 'toggle conditional bp'],
			\ 'f' : ["<Plug>(VimspectorAddFunctionBreakpoint)", 'function breakpoint'],
			\ 'n' : ["<Plug>(VimspectorStepOver)", 'step over'],
			\ 's' : ["<Plug>(VimspectorStepInto)", 'step into'],
			\ 'u' : ["<Plug>(VimspectorStepOut)", 'step out'],
			\ }

" F is for fold
let g:which_key_map.F = {
    \ 'name': '+fold',
    \ 'O' : [':set foldlevel=20'  , 'open all'],
    \ 'C' : [':set foldlevel=0'   , 'close all'],
    \ 'c' : [':foldclose'         , 'close'],
    \ 'o' : [':foldopen'          , 'open'],
    \ '1' : [':set foldlevel=1'   , 'level1'],
    \ '2' : [':set foldlevel=2'   , 'level2'],
    \ '3' : [':set foldlevel=3'   , 'level3'],
    \ '4' : [':set foldlevel=4'   , 'level4'],
    \ '5' : [':set foldlevel=5'   , 'level5'],
    \ '6' : [':set foldlevel=6'   , 'level6']
    \ }

" s is for search powered by telescope
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ 'B' : [':Telescope git_branches'                , 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace diagnostics'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ '*' : [':Telescope grep_string'                  , 'search current word'],
      \ 'F' : [':Telescope file_browser'                , 'file browser'],
      \ '/' : [':Telescope command_history'             , 'history'],
      \ 'h' : [':Telescope git_bcommits'             , 'file history'],
      \ 'i' : [':Telescope media_files'                 , 'media files'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
      \ 'o' : [':Telescope vim_options'                 , 'vim_options'],
      \ 't' : [':Telescope live_grep'                   , 'text'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'c' : [':Telescope colorscheme' , 'colors'],
      \ 'v' : [':TelescopeVim'                 , 'vim-config'],
      \ 'l' : [':TelescopeLatex'                 , 'Latex Symbols'],
      \ 'e' : [':TelescopeEmoji'                 , 'Emoji Symbols'],
      \ 'H' : [':TelescopeHelp'             , 'help'],
      \ 'w' : [':TelescopeWord'             , 'word'],
      \ 's' : [':CtrlSF '               , 'CtrlSF'],
      \ }

" S is for Session
let g:which_key_map.S = {
      \ 'name' : '+Session' ,
      \ 's' : [':SessionSave'           , 'save session'],
      \ 'l' : [':SessionLoad'           , 'load Session'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'b' : [':GitBlameToggle'                   , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'j' : [':NextHunk'                         , 'next hunk'],
      \ 'k' : [':PrevHunk'                         , 'prev hunk'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':PreviewHunk'                      , 'preview hunk'],
      \ 'r' : [':ResetHunk'                        , 'reset hunk'],
      \ 'R' : [':ResetBuffer'                      , 'reset buffer'],
      \ 's' : [':StageHunk'                        , 'stage hunk'],
      \ 'S' : [':Gstatus'                          , 'status'],
      \ 'u' : [':UndoStageHunk'                    , 'undo stage hunk'],
      \ }

" g is for git
let g:which_key_map.g = {
			\ 'name' : '+git' ,
			\ 'a' : [':Git add .'                        , 'add all'],
			\ 'A' : [':Git add %'                        , 'add current'],
			\ 'b' : [':Git blame'                        , 'blame'],
			\ 'B' : [':GBrowse'                          , 'browse'],
			\ 'c' : [':Git commit'                       , 'commit'],
			\ 'd' : [':Git diff'                         , 'diff'],
			\ 'D' : [':Gdiffsplit'                       , 'diff split'],
			\ 'G' : [':GGrep'                            , 'git grep'],
			\ 'g' : [':Gstatus'                          , 'status'],
			\ 'i' : [':!git init'                          , 'init'],
			\ 'l' : [':Git log'                          , 'log'],
			\ 'p' : [':Git push'                         , 'push'],
			\ 'P' : [':Git pull'                         , 'pull'],
			\ 'r' : [':GRemove'                          , 'remove'],
			\ 'S' : [':!git status'                      , 'status'],
			\ 'v' : [':GV'                               , 'view commits'],
			\ 'V' : [':GV!'                              , 'view buffer commits'],
			\ 'm' : [':MergetoolToggle'                  , 'mergetool'],
			\ 'X' : [':!git checkout --conflict=diff3'   , 'reverse mergetool'],
			\ }
" l is for language server protocol
let g:which_key_map.c = {
      \ 'name' : '+lsp' ,
      \ 'a' : [':Lspsaga code_action'                , 'code action'],
      \ 'A' : [':Lspsaga range_code_action'          , 'selected action'],
      \ 'd' : [':Telescope lsp_document_diagnostics' , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace diagnostics'],
      \ 'f' : [':LspFormatting'                      , 'format'],
      \ 'I' : [':LspInfo'                            , 'lsp info'],
      \ 'v' : [':LspVirtualTextToggle'               , 'lsp toggle virtual text'],
      \ 'c' : [':Lspsaga lsp_finder'                 , 'lsp finder'],
      \ 'L' : [':Lspsaga show_line_diagnostics'      , 'line_diagnostics'],
      \ '>' : [':Lspsaga diagnostics_jump_next'      , 'next diagnostic'],
      \ '<' : [':Lspsaga diagnostics_jump_prev'      , 'next diagnostic'],
      \ 'p' : [':Lspsaga preview_definition'         , 'preview definition'],
      \ 'q' : [':Telescope quickfix'                 , 'quickfix'],
      \ 'r' : [':Lspsaga rename'                     , 'rename'],
      \ 'h' : [':Lspsaga signature_help<cr>'         , 'signature help'],
      \ 'T' : [':LspTypeDefinition'                  , 'type defintion'],
      \ 'x' : [':cclose'                             , 'close quickfix'],
      \ 'S' : [':Telescope lsp_document_symbols'     , 'document symbols'],
      \ 's' : [':Telescope lsp_workspace_symbols'    , 'workspace symbols'],
      \ }

let g:which_key_map.S = {
			\ 'name' : '+Session'  ,
			\ 'd' : [':SessionSave' , 'Save Session'] ,
			\ 'c' : [':SessionLoad'  , 'Load Session'] ,
			\ }
let g:which_key_map.v = {
      \ 'name' : '+view' ,
      \ 'w' : [':StripWhitespace'        , 'strip whitespace'],
      \ 'b' : [':call SetBackground()', 'background'],
      \ 'h' : [':call GoHighlight()', 'highlight'],
      \ 'o' : ['<c-w>o', 'only window'],
      \ 'q' : ['<c-w>q', 'close window'],
      \ 'r' : [':call SetupWrapping()'        , 'wrap text'],
      \ 's' : [':set invspel'        , 'spell checker'],
      \ 'c' : [':ContextToggle'        , 'show context'],
      \ }

let g:which_key_map.y = {
			\ 'name' : '+RIPPLE' ,
			\ 'o' : ["<Plug>(ripple-openRepl)", 'open REPL'],
			\ 'y' : ["<Plug>(ripple-send-motion)", 'send motion'],
			\ 'l' : ["<Plug>(ripple-send-line)", 'send motion'],
			\ 'b' : ["<Plug>(ripple-send-buffer)", 'send motion'],
			\ 'p' : ["<Plug>(ripple-send-previous)", 'send last'],
			\}
" " T table mode
let g:which_key_map.T = {
			\ 'name' : '+table' ,
			\ 'm' : [':TableModeToggle' , 'toggle'],
			\ 'e' : [':TableModeEnable' , 'enable'],
			\ 'd' : [':TableModeDisable' , 'disable'],
			\ 'r' : [':TableModeRealign' , 'align'],
			\ 'a' : [':TableModeRealign' , 'align'],
			\ 't' : [':<Plug>(table-mode-tabelize)' , 'make table']
			\}
let g:which_key_map.x = {
      \ 'name' : '+terminal' ,
      \ 'X' : [':FloatermNew' , 'new'],
      \ 'x' : [':FloatermToggle', 'toggle'],
      \ 'f' : [':FloatermNew vifm' , 'vifm'],
      \ 't' : [':FloatermNew ytop' , 'ytop'],
      \ 'P' : [':FloatermNew ipython' ,  'python'],
      \ 'n' : [':FloatermNext' , 'next'],
      \ 'p' : [':FloatermPrev' , 'prev'],
      \ 'r' : [':FloatermSend' , 'send'],
      \ 'g' : [':FloatermNew lazygit', 'lazygit'],
      \ ']' : [':FloatermNext' , 'next'],
      \ '[' : [':FloatermPrev' , 'prev'],
      \ '\' : [':FloatermNew --wintype=normal --position=right' , 'right'],
      \ '-' : [':FloatermNew --wintype=normal --height=0.3 --position=bottom' , 'bottom']
      \ }

let g:which_key_map.t = {
			\ 'name' : '+test' ,
			\ 'n' : [':TestNearest', 'nearest'],
			\ 'f' : [':TestFile', 'file'],
			\ 's' : [':TestSuite', 'suite'],
			\ 't' : [':TestSuite --lf -vv', 'failed'],
			\ 'l' : [':TestLast', 'last'],
			\ 'g' : [':TestVisit', 'visit'],
			\ 'v' : [':TestNearest -vv', 'nearest vv'],
			\ 'd' : [':lua require("dap-python").test_method()', 'debug'],
			\ 'N' : ["<Plug>(ultest-run-nearest)", 'nearest'],
			\ 'F' : ["<Plug>Ultest", 'file'],
			\ ']' : ["<Plug>(ultest-next-fail)", 'next failure'],
			\ '[' : ["<Plug>(ultest-prev-fail)", 'prev failure'],
			\ 'S' : ["<Plug>(ultest-summary-toggle)", 'toggle summary'],
			\ 'G' : ["<Plug>(ultest-summary-jump)", 'goto summary'],
			\ 'O' : ["<Plug>(ultest-output-show)", 'show output'],
			\ 'J' : ["<Plug>(ultest-output-jump)", 'jump to output'],
			\ 'X' : ["<Plug>(ultest-stop-file)", 'stop file'],
			\ 'x' : ["<Plug>(ultest-stop-nearest)", 'stop nearest'],
			\ 'a' : ["<Plug>(ultest-attach)", 'stop nearest'],
			\}

let g:which_key_map.l = {
			\ 'name' : '+LateX',
			\ 'v': [ ':VimtexView' , 'View'],
			\ 'c': [ ':VimtexCompile' , 'Auto Compile'],
			\ 'S': [ ':VimtexStop' , 'Stop'],
			\ 'x': [ ':VimtexCompileSelected' , 'CompileSelected'],
			\ 'X': [ ':VimtexStopAll' , 'StopAll'],
			\ 'C': [ ':VimtexCompileSS' , 'Compile once'],
			\ 'n': [ ':VimtexClean' , 'Clean'],
			\ 'm': [ ':VimtexContextMenu' , 'ContextMenu'],
			\ 'o': [ ':VimtexCompileOutput' , 'CompileOutput'],
			\ 's': [ ':VimtexStatus' , 'Status'],
			\ 't': [ ':VimtexTocToggle' , 'TocToggle'],
			\ 'r': [ ':VimtexReload' , 'Reload'],
			\ 'R': [ ':VimtexReloadState' , 'ReloadState'],
			\ 'L': [ ':VimtexCountLetters' , 'CountLetters'],
			\ 'W': [ ':VimtexCountWords' , 'CountWords'],
			\ 'l': [ ':VimtexLog' , 'Log'],
			\ 'i': [ ':VimtexInfo' , 'Info'],
			\ 'p': [ ':VimtexDocPackage' , 'DocPackage'],
			\ 'P': [ ':call PresentWithPympress()' , 'Present']
			\}
" a is for actions
let g:which_key_map.a = {
			\ 'name' : '+actions' ,
			\ 'h' : [':let @/ = ""'            , 'remove search highlight'],
			\ 'n' : [':set nonumber!'          , 'line-numbers'],
			\ 'r' : [':set norelativenumber!'  , 'relative line nums'],
			\ 't' : [':FloatermToggle'         , 'terminal'],
			\ 'w' : [':StripWhitespace'        , 'strip whitespace'],
			\ 's' : ['[s1z=`]'                 , 'correct spelling'],
			\ 'y' : [':let @+= expand("%")'    , 'copy path'],
			\ }
call which_key#register('<Space>', "g:which_key_map")
