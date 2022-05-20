local status_ok, tmuxnav = pcall(require, "nvim-tmux-navigator")
if not status_ok then
	print("TMUX navigator not loaded")
	return
end
tmuxnav.setup{
    bindings = {
        left = '<C-H>',
        down = '<C-J>',
        up = '<C-K>',
        right = '<C-L>',
        previous = '<C-\\>'
    }
}

-- vim.cmd([[
-- 	let g:tmux_navigator_no_mappings = 1
-- 	nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
-- 	nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
-- 	nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
-- 	nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
-- 	nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
-- 	nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
-- 	nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
-- 	nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
-- 	nnoremap <silent> <c-;> :TmuxNavigateRight<cr>
-- ]])
