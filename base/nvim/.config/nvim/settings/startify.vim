let g:startify_session_dir = '~/.local/nvim/yasser/session'
let g:startify_custom_header = ['']
let g:startify_bookmarks = [
            \ { 'd': '~/code/personal/dotfiles' },
            \ { 'z': '~/.zshrc' },
            \ { 'c': '~/code/projects'},
            \ { 'r': '~/code/presentations'},
            \ { 'p': '~/storage/gdrive/research/papers/mypapers'},
            \ ]
let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ ]
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1
" let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 0
