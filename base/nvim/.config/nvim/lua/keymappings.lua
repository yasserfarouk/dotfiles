vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- my most import map
vim.api.nvim_set_keymap('n', ';', ':', {noremap = true, silent = false})
vim.api.nvim_set_keymap('v', ';', ':', {noremap = true, silent = false})
vim.api.nvim_set_keymap('n', ':', ';', {noremap = true, silent = false})
vim.api.nvim_set_keymap('v', ':', ';', {noremap = true, silent = false})
-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})
vim.api.nvim_set_keymap('n', '<Left>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<Up>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<Down>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<Right>', '<C-w>l', {silent = true})
vim.api.nvim_set_keymap('n', '==', 'ggVG=<C-o>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<esc>[s1z=`]a', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {silent = true, noremap = true})

-- splitting 
vim.api.nvim_set_keymap('n', '-', '<C-W>s', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '_', '<C-W>v', {silent = true, noremap = true})
-- folding
vim.api.nvim_set_keymap('n', '\\', 'za', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'S-\\', 'zO', {silent = true, noremap = true})

-- center things
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<C-i>', '<C-i>zz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'z-', 'z^', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '}', '}zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '{', '{zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', ']]', ']]zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '[[', '[[zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '[]', '[]zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '][', '][zvzz', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<BS>', 'i<BS>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<leader>z', 'zMzvzz', {silent = true, noremap = true})

-- navigate matching list and preview window
vim.api.nvim_set_keymap('n', '<silent>]t', ':tnext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>[t', ':tprev<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>]T', ':tlast<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>[T', ':tfirst<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>]p', ':ptnext<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>[p', ':ptprev<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>]P', ':ptlast<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<silent>[P', ':ptfirst<CR>', {silent = true, noremap = true})
-- TODO fix this
-- Terminal window navigation
vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])

-- TODO fix this
-- resize with arrows
vim.cmd([[
  nnoremap <silent> <S-Up>    :resize -2<CR>
  nnoremap <silent> <S-Down>  :resize +2<CR>
  nnoremap <silent> <S-Left>  :vertical resize -2<CR>
  nnoremap <silent> <S-Right> :vertical resize +2<CR>
]])

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- I hate escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
-- vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')
-- vim.cmd('inoremap <expr> <TAB> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <S-TAB> (\"\\<C-p>\")')

-- vim.api.nvim_set_keymap('i', '<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true})

-- vim.cmd([[
-- map p <Plug>(miniyank-autoput)
-- map P <Plug>(miniyank-autoPut)
-- map <leader>n <Plug>(miniyank-cycle)
-- map <leader>N <Plug>(miniyank-cycleback)
-- ]])
