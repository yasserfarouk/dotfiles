let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'javascript': ['eslint'],
			\   'python': [ 'isort'],
			\}

let g:ale_linters = {
			\ 'python': ['pyls'],
			\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0

" let g:neomake_verbose = 3
let g:ale_sign_warning = '•'
" let g:ale_lint_on_text_changed = 'always'
" let g:ale_lint_on_enter = 1
