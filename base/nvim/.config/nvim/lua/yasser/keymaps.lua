local keymap = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = ","
keymap("n", "<Space>", "<NOP>")
-- never go to this weird mode
keymap("n", "Q", "<nop>")
-- my most import map
keymap("n", "<C-i>", "<C-i>")
keymap("n", ";", ":")
keymap("v", ";", ":")
keymap("n", ":", ";")
keymap("v", ":", ";")

-- vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
-- vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
-- vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
-- vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
-- vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })
keymap("n", "==", "ggVG=<C-o>")
keymap("i", "<C-s>", "<esc>[s1z=`]a")
keymap("n", "Y", "y$")
-- keymap("n", "<F2>", ":lua vim.lsp.buf.rename()<cr>")

-- splitting
-- keymap("n", "-", "<C-W>s")
-- keymap("n", "|", "<C-W>v")
-- folding
keymap("n", "\\", "za")
keymap("n", "S-\\", "zO")

-- center things
keymap("n", "<C-o>", "<C-o>zz")
keymap("n", "<C-i>", "<C-i>zz")
keymap("n", "z-", "z^")
keymap("n", "}", "}zvzz")
keymap("n", "n", "nzvzz")
keymap("n", "N", "Nzvzz")
keymap("n", "{", "{zvzz", { silent = true, noremap = true })
keymap("n", "]]", "]]zvzz")
keymap("n", "[[", "[[zvzz")
keymap("n", "[]", "[]zvzz")
keymap("n", "][", "][zvzz")
keymap("n", "<BS>", "i<BS>")
keymap("n", "<leader>z", "zMzvzz")

-- navigate matching list and preview window
keymap("n", "<silent>]t", ":tnext<CR>")
keymap("n", "<silent>[t", ":tprev<CR>")
keymap("n", "<silent>]T", ":tlast<CR>")
keymap("n", "<silent>[T", ":tfirst<CR>")
keymap("n", "<silent>]p", ":ptnext<CR>")
keymap("n", "<silent>[p", ":ptprev<CR>")
keymap("n", "<silent>]P", ":ptlast<CR>")
keymap("n", "<silent>[P", ":ptfirst<CR>")
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
-- resize windows (using Alt+hjkl for vim-style)
keymap("n", "<Up>", "<C-w>k")
keymap("n", "<Down>", "<C-w>j")
keymap("n", "<Left>", "<C-w>h")
keymap("n", "<Right>", "<C-w>l")
keymap("n", "<M-k>", ":resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<M-j>", ":resize +2<CR>", { desc = "Increase height" })
keymap("n", "<M-h>", ":vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<M-l>", ":vertical resize +2<CR>", { desc = "Increase width" })
-- move windows around
keymap("n", "<M-S-Up>", "<C-w>K")
keymap("n", "<M-S-Down>", "<C-w>J")
keymap("n", "<M-S-Right>", "<C-w>L")
keymap("n", "<M-S-Left>", "<C-w>H")

-- whichkey movement and size change commands
-- keymap("n", "<leader>Wk", "<C-w>K", { desc = "Move Top" })
-- keymap("n", "<leader>Wj", "<C-w>J", { desc = "Move Bottom" })
-- keymap("n", "<leader>Wl", "<C-w>L", { desc = "Move Right" })
-- keymap("n", "<leader>Wh", "<C-w>H", { desc = "Move Left" })
-- keymap("n", "<leader>WK", ":resize -2<CR>", { desc = "Shrink Up" })
-- keymap("n", "<leader>WJ", ":resize +2<CR>", { desc = "Grow Up" })
-- keymap("n", "<leader>WL", ":vertical resize -2<CR>", { desc = "Grow Right" })
-- keymap("n", "<leader>WH", ":vertical resize +2<CR>", { desc = "Grow Left" })
-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- I hate escape
keymap("i", "jk", "<ESC>")

-- Tab switch buffer
keymap("n", "<S-TAB>", ":bnext<CR>")
-- keymap('n', '<S-TAB>', ':bprevious<CR>')

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "J", ":move '>+1<CR>gv-gv")

-- -- easy buffer navigation
-- keymap("n", "gb", "<cmd>BufferLinePick<CR>")

-- highlight last inserted text
keymap({ "n" }, "gV", [[`[v`]']])

-- Execute "q" macro over visual line selections
keymap({ "x" }, "Q", [[:'<,'>:normal @q<CR>]])

-- Use / to search inside a visual selection
keymap("x", "/", "<Esc>/\\%V")

-- keymap("n", "<esc><esc>", ":set hlsearch!<CR>")
keymap("n", "<esc><esc>", "<cmd>let @/ = ''<cr>", { desc = "no highlight" })
-- whichkey maps
-- no hl
keymap("n", "<leader>w", "<cmd>wa<cr>", { desc = "save all" })
keymap("n", "<leader>q", "<C-W>c", { desc = "quit window" })
keymap("n", "<leader>-", "<C-W>s", { desc = "split below" })
keymap("n", "<leader>\\", "<C-W>v", { desc = "split right" })
keymap("n", "<leader>=", "<C-W>=", { desc = "balance windows" })
keymap("n", "<leader>zm", "<C-W>m", { desc = "zoom window" })
-- buffer operations
keymap("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "close others" })
keymap("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "next" })
keymap("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "prev" })
keymap("n", "<leader>bk", "<cmd>blast<cr>", { desc = "last" })
keymap("n", "<leader>bj", "<cmd>bfirst<cr>", { desc = "first" })
keymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "next-buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "previous-buffer" })
keymap("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "delete-buffer" })
-- folding operations
keymap("n", "<leader>FO", "<cmd>set foldlevel=20<cr>", { desc = "open all" })
keymap("n", "<leader>FC", "<cmd>set foldlevel=0<cr>", { desc = "close all" })
keymap("n", "<leader>Fc", "<cmd>foldclose<cr>", { desc = "close" })
keymap("n", "<leader>Fo", "<cmd>foldopen<cr>", { desc = "open" })
keymap("n", "<leader>F1", "<cmd>set foldlevel=1<cr>", { desc = "level1" })
keymap("n", "<leader>F2", "<cmd>set foldlevel=2<cr>", { desc = "level2" })
keymap("n", "<leader>F3", "<cmd>set foldlevel=3<cr>", { desc = "level3" })
keymap("n", "<leader>F4", "<cmd>set foldlevel=4<cr>", { desc = "level4" })
keymap("n", "<leader>F5", "<cmd>set foldlevel=5<cr>", { desc = "level5" })
keymap("n", "<leader>F6", "<cmd>set foldlevel=6<cr>", { desc = "level6" })
-- view maps
keymap("n", "<leader>vw", "<cmd>StripWhitespace<cr>", { desc = "strip whitespace" })
keymap("n", "<leader>vb", "<cmd>call SetBackground()<cr>", { desc = "background" })
keymap("n", "<leader>vh", "<cmd>call GoHighlight()<cr>", { desc = "highlight" })
keymap("n", "<leader>vo", "<c-w>o", { desc = "only window" })
keymap("n", "<leader>vq", "<c-w>q", { desc = "close window" })
keymap("n", "<leader>vr", "<cmd>call SetupWrappingSoft()<cr>", { desc = "wrap text (soft)" })
keymap("n", "<leader>vR", "<cmd>call SetupWrappingHard()<cr>", { desc = "wrap text (hard)" })
keymap("n", "<leader>vs", "<cmd>set spell!<cr>", { desc = "spell checker" })
keymap("n", "<leader>vS", "<cmd>set scrollbind!<cr>", { desc = "bind scrolling" })
-- general actions
keymap("n", "<leader>ah", "<cmd>let @/ = ''<cr>", { desc = "remove search highlight" })
keymap("n", "<leader>an", "<cmd>set nonumber!<cr>", { desc = "line-numbers" })
keymap("n", "<leader>ar", "<cmd>set norelativenumber!<cr>", { desc = "relative line nums" })
keymap("n", "<leader>as", "<cmd>Ds1z=`]<cr>", { desc = "correct spelling" })
keymap("n", "<leader>ay", "<cmd>let @+= expand(' % ')<cr>", { desc = "copy path" })
keymap("n", "<leader>al", "<cmd>%s/^/\\=printf('%-4d', line('.'))<cr>", { desc = "write line numbers" })
keymap("n", "<leader>ax", "<cmd>cclose<cr>", { desc = "close quickfix" })
keymap("n", "<leader>aL", "<cmd>g/^$/.,./-j<cr>", { desc = "remove extra empty lines" })

-- opening yazi
keymap(
	"n",
	"<leader>x;",
	":silent !tmux split-window -f -t : yazi<CR>",
	-- ':!tmux split-window -f -c "#{pane_current_path}" -t : yazi<CR>',
	{ noremap = true, silent = true, desc = "Yazi in a split" }
)
keymap(
	"n",
	"<leader>xw",
	-- ':silent !tmux new-window -d -n yazi -c "#{pane_current_path}" "yazi"<CR><C-w>\\',
	':silent !tmux new-window -d -n yazi "yazi"<CR><C-w>\\',
	{ noremap = true, silent = true, desc = "Yazi in a full tmux pane" }
)
keymap(
	"n",
	"<leader>xy",
	':!tmux popup -E -w 80\\% -h 80\\% "yazi"<CR>',
	{ noremap = true, silent = true, desc = "Yazi in a tumux float" }
)
