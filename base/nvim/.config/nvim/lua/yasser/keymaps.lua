local keymap = vim.keymap.set
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
keymap('n', '<Space>', '<NOP>')
-- never go to this weird mode
keymap("n", "Q", "<nop>")
-- my most import map
keymap("n", "<C-i>", "<C-i>")
keymap('n', ';', ':')
keymap('v', ';', ':')
keymap('n', ':', ';')
keymap('v', ':', ';')
-- no hl
keymap('n', '<esc><esc>', ':set hlsearch!<CR>')

-- explorer
keymap('n', '<Leader>e', ':NvimTreeToggle<CR>')
-- vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
-- vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
-- vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
-- vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
-- vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})
keymap('n', '<Left>', '<C-w>h')
keymap('n', '<Up>', '<C-w>k')
keymap('n', '<Down>', '<C-w>j')
keymap('n', '<Right>', '<C-w>l')
keymap('n', '==', 'ggVG=<C-o>')
keymap('i', '<C-s>', '<esc>[s1z=`]a')
keymap('n', 'Y', 'y$')
keymap('n', '<F2>', ':lua vim.lsp.buf.rename()<cr>')

-- splitting
keymap('n', '-', '<C-W>s')
keymap('n', '_', '<C-W>v')
-- folding
keymap('n', '\\', 'za')
keymap('n', 'S-\\', 'zO')

-- center things
keymap('n', '<C-o>', '<C-o>zz')
keymap('n', '<C-i>', '<C-i>zz')
keymap('n', 'z-', 'z^')
keymap('n', '}', '}zvzz')
keymap('n', 'n', 'nzvzz')
keymap('n', 'N', 'Nzvzz')
keymap('n', '{', '{zvzz', { silent = true, noremap = true })
keymap('n', ']]', ']]zvzz')
keymap('n', '[[', '[[zvzz')
keymap('n', '[]', '[]zvzz')
keymap('n', '][', '][zvzz')
keymap('n', '<BS>', 'i<BS>')
keymap('n', '<leader>z', 'zMzvzz')

-- navigate matching list and preview window
keymap('n', '<silent>]t', ':tnext<CR>')
keymap('n', '<silent>[t', ':tprev<CR>')
keymap('n', '<silent>]T', ':tlast<CR>')
keymap('n', '<silent>[T', ':tfirst<CR>')
keymap('n', '<silent>]p', ':ptnext<CR>')
keymap('n', '<silent>[p', ':ptprev<CR>')
keymap('n', '<silent>]P', ':ptlast<CR>')
keymap('n', '<silent>[P', ':ptfirst<CR>')
-- TODO fix this
-- Terminal window navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h")
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l")
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l")
keymap("t", "<Esc>", "<C-\\><C-n>")

-- keep place when joining lines
keymap("n", "J", "mzJ`z")

-- paste and keep old copy
keymap("x", "<localleader>p", [["_dP]])
keymap("x", "<leader>p", [["_dP]])
keymap({ "n", "v" }, "<leader>D", [["_d]])
keymap({ "n", "v" }, "<localleader>d", [["_d]])
-- TODO fix this
-- resize with arrows
keymap("n",  "<S-Up>", ":resize -2<CR>")
keymap("n",  "<S-Down>", ":resize +2<CR>")
keymap("n",  "<S-Left>", ":vertical resize -2<CR>")
keymap("n",  "<S-Right>", ":vertical resize +2<CR>")
-- better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- I hate escape
keymap('i', 'jk', '<ESC>')
-- vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

-- Tab switch buffer
keymap('n', '<TAB>', ':bnext<CR>')
keymap('n', '<S-TAB>', ':bprevious<CR>')

-- Move selected line / block of text in visual mode
keymap('x', 'K', ':move \'<-2<CR>gv-gv')
keymap('x', 'J', ':move \'>+1<CR>gv-gv')

-- easy buffer navigation
keymap('n', "gb", "<cmd>BufferLinePick<CR>")
