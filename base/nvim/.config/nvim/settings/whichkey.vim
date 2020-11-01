
function! GoHighlight()
	syntax on
	syntax sync fromstart
endfunction!

function! GoogleSearch()
	let searchterm = getreg("g")
	silent! exec "silent! !chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
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
		if &colors != 'gruvbox'
			execute "set colors=gruvbox"
		endif
		execute "set background=light"
	else
		execute "set background=dark"
	endif
endfunction
" Leader Key Maps

let @s = 'veS"'

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
set timeoutlen=150

" Coc Search & refactor

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want

if has('macunix')
	" Open current directory in Finder
	let g:which_key_map['o'] = [ ':silent exec "!open %:p:h" \| redraw!'                    , 'open dir' ]
endif
" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
			\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

nnoremap <leader>w :wall<cr>
" ignored mappings
let g:which_key_map['<F8>'] = 'which_key_ignore'
let g:which_key_map['<F9>'] = 'which_key_ignore'
let g:which_key_map['['] = 'which_key_ignore'
let g:which_key_map[']'] = 'which_key_ignore'
let g:which_key_map['z'] = 'which_key_ignore'
let g:which_key_map['*'] = 'which_key_ignore'
let g:which_key_map['q'] = 'which_key_ignore'
let g:which_key_map['w'] = 'which_key_ignore'
" mappings with existing keys
let g:which_key_map['/'] = 'search word'
" let g:which_key_map['*'] = 'visual star'
"" Single mappings
" let g:which_key_map['#'] = [ ':call Comment()'                    , 'comment' ]
let g:which_key_map['.'] = [ ':vs $MYVIMRC'                        , 'open init' ]
let g:which_key_map[';'] = [ ':Commands'                          , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                             , 'balance windows' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'               , 'explorer' ]
let g:which_key_map['-'] = [ '<C-W>s'                             , 'split below']
let g:which_key_map['|'] = [ '<C-W>v'                             , 'split right']
let g:which_key_map['f'] = [ ':Files'                             , 'search files' ]
let g:which_key_map['q'] = [ 'wq'                                  , 'quit' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                    , 'undo tree']
" let g:which_key_map['d'] = [ '"_d'                                  , 'delete text' ]
" let g:which_key_map['D'] = [ '"_D'                                  , 'delete to end' ]
" let g:which_key_map['p'] = [ ':call PandocPDF()'                     , 'make pdf' ]
" let g:which_key_map['w'] = [ ':wall'                               , 'save all' ]
" let g:which_key_map['r'] = [ ':RnvimrToggle'                      , 'ranger' ]
" let g:which_key_map['T'] = [ ':TSHighlightCapturesUnderCursor'    , 'treesitter highlight' ]
" let g:which_key_map['m'] = [ ':call WindowSwap#EasyWindowSwap()'  , 'move window' ]
" Group mappings

" m for markdown
let g:which_key_map.m = {
			\ 'name' : '+markdown',
			\ 'c' : [':call PandocPDF()' , 'compile pdf'],
			\ 'p' : [':MarkdownPreview' , 'preview']
			\}
" a is for actions
let g:which_key_map.a = {
			\ 'name' : '+actions' ,
			\ 'c' : [':Colors'        , 'colors'],
			\ 'e' : [':CocCommand explorer'    , 'explorer'],
			\ 'h' : [':let @/ = ""'            , 'remove search highlight'],
			\ 'm' : [':MarkdownPreview'        , 'markdown preview'],
			\ 'M' : [':MarkdownPreviewStop'    , 'markdown preview stop'],
			\ 'n' : [':set nonumber!'          , 'line-numbers'],
			\ 'r' : [':set norelativenumber!'  , 'relative line nums'],
			\ 't' : [':FloatermToggle'         , 'terminal'],
			\ 'v' : [':Codi'                   , 'virtual repl on'],
			\ 'V' : [':Codi!'                  , 'virtual repl off'],
			\ 'w' : [':StripWhitespace'        , 'strip whitespace'],
			\ }

" d is for debug
let g:which_key_map.d = {
			\ 'name' : '+debug' ,
			\ 'd' : [':call vimspector#Launch()<cr>'        , 'launch debugger'],
			\ 'x' : [':VimspectorReset<CR>' , 'reset'],
			\ 'e' : [':VimspectorEval<space>' , 'eval'],
			\ 'w' : [':VimspectorWatch<space>' , 'watch'],
			\ 'o' : [':VimspectorShowOutput<space>' , 'output'],
			\ 'R' : [':VimspectorRestart<cr>' , 'restart'],
			\ 'c' : [ '<Plug>VimspectorContinue', 'continue'],
			\ 'C' : [ '<Plug>VimspectorStop', 'stop'],
			\ 'r' : [ '<Plug>VimspectorRestart', 'restart'],
			\ 'p' : [ '<Plug>VimspectorPause', 'pause'],
			\ 'b' : [ '<Plug>VimspectorToggleBreakpoint', 'roggle breakpoint'],
			\ 'B' : [ '<Plug>VimspectorToggleConditionalBreakpoint', 'toggle conditional bp'],
			\ 'f' : [ '<Plug>VimspectorAddFunctionBreakpoint', 'function breakpoint'],
			\ 'n' : [ '<Plug>VimspectorStepOver', 'step over'],
			\ 's' : [ '<Plug>VimspectorStepInto', 'step into'],
			\ 'u' : [ '<Plug>VimspectorStepOut', 'step out'],
			\ }

" b is for buffer
let g:which_key_map.b = {
			\ 'name' : '+buffer' ,
			\ '>' : [':bn'        , 'move next'],
			\ '<' : [':bp'    , 'move prev'],
			\ 'b' : [':Buffers'            , 'pick buffer'],
			\ 'd' : [':bd'               , 'delete-buffer'],
			\ 'D' : [':BufferOrderByDirectory', 'order by directory'],
			\ 'f' : ['bfirst'                 , 'first-buffer'],
			\ 'l' : ['blast'                  , 'last buffer'],
			\ 'L' : [':BufferOrderByLanguage' , 'order by language'],
			\ 'n' : ['bnext'                  , 'next-buffer'],
			\ 'p' : ['bprevious'              , 'previous-buffer'],
			\ '?' : ['Buffers'                , 'fzf-buffer'],
			\ }

" f is for find and replace
let g:which_key_map.r = {
			\ 'name' : '+find & replace' ,
			\ 'b' : [':Farr --source=vimgrep'    , 'buffer'],
			\ 'p' : [':Farr --source=rgnvim'     , 'project'],
			\ }

" \ 'w' : [':let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s<CR><Esc><C-o>', 'remove whitespace'],
let g:which_key_map.v = {
			\ 'name' : '+view' ,
			\ 'w' : [':StripWhitespace'        , 'strip whitespace'],
			\ 'b' : [': call SetBackground()', 'background'],
			\ 'h' : [': call GoHighlight()', 'highlight'],
			\}

let g:which_key_map.o = {
			\ 'name' : '+miscellaneous' ,
			\ 'y' : [':let @+= expand("%")', 'copy path'],
			\}

let g:which_key_map.x = {
			\ 'name' : '+terminal' ,
			\ 'X' : [':FloatermNew' , 'new'],
			\ 'x' : [':FloatermToggle', 'toggle'],
			\ 'f' : [':FloatermNew vifm' , 'vifm'],
			\ 't' : [':FloatermNew ytop' , 'ytop'],
			\ 'G' : [':FloatermNew lazygit', 'lazygit'],
			\ 'P' : [':FloatermNew ipython' ,  'python'],
			\ 'n' : [':FloatermNext' , 'next'],
			\ 'p' : [':FloatermPrev' , 'prev'],
			\ 'V' : [':FloatermNew --wintype=normal --position=right' , 'right'],
			\ 'H' : [':FloatermNew --wintype=normal --height=0.3 --position=bottom' , 'bottom'],
			\ 'R' : [':FloatermSend' , 'send']
			\}
" " k is for task
" let g:which_key_map.k = {
" 			\ 'name' : '+task' ,
" 			\ 'c' : [':AsyncTask file-compile'      , 'compile file'],
" 			\ 'b' : [':AsyncTask project-build'     , 'build project'],
" 			\ 'e' : [':AsyncTaskEdit'               , 'edit local tasks'],
" 			\ 'f' : [':AsyncTaskFzf'                , 'find task'],
" 			\ 'g' : [':AsyncTaskEdit!'              , 'edit global tasks'],
" 			\ 'h' : [':AsyncTaskList!'              , 'list hidden tasks'],
" 			\ 'l' : [':CocList tasks'               , 'list tasks'],
" 			\ 'm' : [':AsyncTaskMacro'              , 'macro help'],
" 			\ 'o' : [':copen'                       , 'open task view'],
" 			\ 'r' : [':AsyncTask file-run'          , 'run file'],
" 			\ 'p' : [':AsyncTask project-run'       , 'run project'],
" 			\ 'x' : [':cclose'                      , 'close task view'],
" 			\ }
" " \ 'l' : [':AsyncTaskList'               , 'list tasks'],

" s is for search
let g:which_key_map.s = {
			\ 'name' : '+search' ,
			\ '/' : [':History/'              , 'history'],
			\ ';' : [':Commands'              , 'commands'],
			\ 'r' : ['<Plug>CtrlSFPrompt'              , 'CtrlSF'],
			\ 'a' : [':Ag'                    , 'text Ag'],
			\ 'b' : [':BLines'                , 'current buffer'],
			\ 'B' : [':Buffers'               , 'open buffers'],
			\ 'c' : [':Commits'               , 'commits'],
			\ 'C' : [':BCommits'              , 'buffer commits'],
			\ 'f' : [':Files'                 , 'files'],
			\ 'g' : [':GFiles'                , 'git files'],
			\ 'G' : [':GFiles?'               , 'modified git files'],
			\ 'h' : [':History'               , 'file history'],
			\ 'H' : [':History:'              , 'command history'],
			\ 'l' : [':Lines'                 , 'lines'] ,
			\ 'm' : [':Marks'                 , 'marks'] ,
			\ 'M' : [':Maps'                  , 'normal maps'] ,
			\ 'p' : [':Helptags'              , 'help tags'] ,
			\ 'P' : [':Tags'                  , 'project tags'],
			\ 's' : [':CocList snippets'      , 'snippets'],
			\ 'S' : [':Colors'                , 'color schemes'],
			\ 't' : [':Rg'                    , 'text Rg'],
			\ 'T' : [':BTags'                 , 'buffer tags'],
			\ 'w' : [':Windows'               , 'search windows'],
			\ 'y' : [':Filetypes'             , 'file types'],
			\ 'z' : [':FZF'                   , 'FZF'],
			\ }
" \ 's' : [':Snippets'     , 'snippets'],

let g:which_key_map.S = {
			\ 'name' : '+Session' ,
			\ 'd' : [':Obsession!'         , 'Delete Session'] ,
			\ 'c' : [':Obsession'           , 'Create Session']     ,
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
			\ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
			\ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
			\ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
			\ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
			\ 's' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'],
			\ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
			\ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
			\ 'v' : [':GV'                               , 'view commits'],
			\ 'V' : [':GV!'                              , 'view buffer commits'],
			\ }

" c is for CoC
let g:which_key_map.c = {
			\ 'name' : '+lsp' ,
			\ '.' : [':CocConfig'                          , 'config'],
			\ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
			\ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
			\ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
			\ 'b' : [':CocNext'                            , 'next action'],
			\ 'B' : [':CocPrev'                            , 'prev action'],
			\ 'c' : [':CocList commands'                   , 'commands'],
			\ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
			\ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
			\ 'e' : [':CocList extensions'                 , 'extensions'],
			\ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
			\ 'F' : ['<Plug>(coc-format)'                  , 'format'],
			\ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
			\ 'I' : ['<Plug>(coc-implementation)'          , 'implementation'],
			\ 'i' : [':CocList diagnostics'                , 'diagnostics'],
			\ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
			\ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
			\ 'N' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
			\ 'n' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
			\ 'o' : [':CocList outline'                    , 'outline'],
			\ 'P' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
			\ 'p' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
			\ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
			\ 'r' : ['<Plug>(coc-references)'              , 'references'],
			\ 'R' : ['<Plug>(coc-rename)'                  , 'rename'],
			\ 's' : [':CocList -I symbols'                 , 'references'],
			\ 'S' : [':CocList snippets'                   , 'snippets'],
			\ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
			\ 'u' : [':CocListResume'                      , 'resume list'],
			\ 'U' : [':CocUpdate'                          , 'update CoC'],
			\ 'z' : [':CocDisable'                         , 'disable CoC'],
			\ 'Z' : [':CocEnable'                          , 'enable CoC'],
			\ }
" \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],

let g:which_key_map.t = {
			\ 'name' : '+test' ,
			\ 'n' : [':TestNearest', 'nearest'],
			\ 'f' : [':TestFile', 'file'],
			\ 's' : [':TestSuite', 'suite'],
			\ 'l' : [':TestLast', 'last'],
			\ 'v' : [':TestVisit', 'visit'],
			\}

" nunmap <space>tm
" nunmap <space>tt
" " T table mode
let g:which_key_map.T = {
			\ 'name' : '+table' ,
			\ 'm' : [':TableModeToggle' , 'toggle'],
			\ 'e' : [':TableModeEnable' , 'enable'],
			\ 'd' : [':TableModeDisable' , 'disable'],
			\ 'r' : [':TableModeRealign' , 'align'],
			\ 'a' : [':TableModeRealign' , 'align'],
			\ 't' : ['<Plug>(table-mode-tabelize)' , 'make table']
			\}
" let g:which_key_map.T = {
"       \ 'name' : '+tabline' ,
"       \ 'b' : [':XTabListBuffers'         , 'list buffers'],
"       \ 'd' : [':XTabCloseBuffer'         , 'close buffer'],
"       \ 'D' : [':XTabDeleteTab'           , 'close tab'],
"       \ 'h' : [':XTabHideBuffer'          , 'hide buffer'],
"       \ 'i' : [':XTabInfo'                , 'info'],
"       \ 'l' : [':XTabLock'                , 'lock tab'],
"       \ 'm' : [':XTabMode'                , 'toggle mode'],
"       \ 'n' : [':tabNext'                 , 'next tab'],
"       \ 'N' : [':XTabMoveBufferNext'      , 'buffer->'],
"       \ 't' : [':tabnew'                  , 'new tab'],
"       \ 'p' : [':tabprevious'             , 'prev tab'],
"       \ 'P' : [':XTabMoveBufferPrev'      , '<-buffer'],
"       \ 'x' : [':XTabPinBuffer'           , 'pin buffer'],
"       \ }

" " w is for wiki
" let g:which_key_map.w = {
" 			\ 'name' : '+wiki' ,
" 			\ 'w' : ['<Plug>VimwikiIndex'                              , 'ncdu'],
" 			\ 'n' : ['<plug>(wiki-open)'                              , 'ncdu'],
" 			\ 'j' : ['<plug>(wiki-journal)'                              , 'ncdu'],
" 			\ 'R' : ['<plug>(wiki-reload)'                              , 'ncdu'],
" 			\ 'c' : ['<plug>(wiki-code-run)'                              , 'ncdu'],
" 			\ 'b' : ['<plug>(wiki-graph-find-backlinks)'                              , 'ncdu'],
" 			\ 'g' : ['<plug>(wiki-graph-in)'                              , 'ncdu'],
" 			\ 'G' : ['<plug>(wiki-graph-out)'                              , 'ncdu'],
" 			\ 'l' : ['<plug>(wiki-link-toggle)'                              , 'ncdu'],
" 			\ 'd' : ['<plug>(wiki-page-delete)'                              , 'ncdu'],
" 			\ 'r' : ['<plug>(wiki-page-rename)'                              , 'ncdu'],
" 			\ 't' : ['<plug>(wiki-page-toc)'                              , 'ncdu'],
" 			\ 'T' : ['<plug>(wiki-page-toc-local)'                              , 'ncdu'],
" 			\ 'e' : ['<plug>(wiki-export)'                              , 'ncdu'],
" 			\ 'u' : ['<plug>(wiki-list-uniq)'                              , 'ncdu'],
" 			\ 'U' : ['<plug>(wiki-list-uniq-local)'                              , 'ncdu'],
" 			\ }
"

let g:which_key_map.l = {
			\ 'name' : '+LateX',
			\ 'v': [ ':VimtexView' , 'View'],
			\ 'c': [ ':VimtexCompile' , 'Compile'],
			\ 'S': [ ':VimtexStop' , 'Stop'],
			\ 'x': [ ':VimtexCompileSelected' , 'CompileSelected'],
			\ 'X': [ ':VimtexStopAll' , 'StopAll'],
			\ 'C': [ ':VimtexCompileSS' , 'CompileSS'],
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
			\ 'p': [ ':VimtexDocPackage' , 'DocPackage']
			\}
call which_key#register('<Space>', "g:which_key_map")
