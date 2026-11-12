-- Chrome-less "prompt editor" mode for small tmux popups (driven by base/programs/bin/popup-edit,
-- used by wm-new, wm-rename and tmux-run-popup). Loaded after the normal config:
--   nvim -c 'lua require("yasser.prompt_popup").setup()' FILE
-- No statusline/tabline/cmdline row/number/sign columns; starts in insert mode at the end of the
-- last line. Environment:
--   PROMPT_POPUP_HINT    dim hint lines (newline-separated): below the text while the buffer is
--                        empty, or (line mode) always, above the last line when there's history
--   PROMPT_POPUP_MODE    "line": the result is only the line under the cursor (earlier lines are
--                        history to pick from, like q:), and insert-mode <CR> submits too
--   PROMPT_POPUP_SYNTAX  syntax highlighting to use (no filetype, so no ftplugin/LSP)
--   <C-s> (normal/insert), <CR> (normal)  save and quit = submit
--   <C-c> (normal), ZQ, :q!, :cq           cancel (an empty result also counts as cancel)
local M = {}

local function chrome_off()
	local o = vim.o
	o.laststatus = 0
	o.showtabline = 0
	o.cmdheight = 0
	o.ruler = false
	o.showcmd = false
	o.winbar = ""
	local wo = vim.wo
	wo.number = false
	wo.relativenumber = false
	wo.signcolumn = "no"
	wo.foldcolumn = "0"
	wo.colorcolumn = ""
	wo.cursorline = false
	wo.wrap = true
	wo.spell = false
	wo.fillchars = "eob: "
end

function M.setup()
	vim.bo.swapfile = false
	vim.bo.filetype = "text"
	local line_mode = os.getenv("PROMPT_POPUP_MODE") == "line"
	local syn = os.getenv("PROMPT_POPUP_SYNTAX")
	if syn and syn ~= "" then vim.bo.syntax = syn end
	chrome_off()
	-- lazy.nvim's VeryLazy plugins (bufferline etc.) load after -c commands; re-apply once they did.
	vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", once = true, callback = function() vim.schedule(chrome_off) end })
	vim.defer_fn(chrome_off, 100)

	local submit = function()
		if line_mode then vim.api.nvim_buf_set_lines(0, 0, -1, false, { vim.api.nvim_get_current_line() }) end
		vim.cmd("silent! write | qall!")
	end
	vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.cmd("stopinsert") submit() end, { buffer = true })
	vim.keymap.set("n", "<CR>", submit, { buffer = true })
	if line_mode then
		vim.keymap.set("i", "<CR>", function() vim.cmd("stopinsert") submit() end, { buffer = true })
	end
	vim.keymap.set("n", "<C-c>", "<cmd>cquit!<cr>", { buffer = true })

	local hint = os.getenv("PROMPT_POPUP_HINT")
	if hint and hint ~= "" then
		local ns = vim.api.nvim_create_namespace("prompt_popup")
		local function update()
			vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local virt = {}
			for l in hint:gmatch("[^\n]+") do table.insert(virt, { { l, "Comment" } }) end
			if line_mode and #lines > 1 then
				vim.api.nvim_buf_set_extmark(0, ns, #lines - 1, 0, { virt_lines = virt, virt_lines_above = true })
			elseif line_mode or (#lines <= 1 and (lines[1] or "") == "") then
				vim.api.nvim_buf_set_extmark(0, ns, 0, 0, { virt_lines = virt })
			end
		end
		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, { buffer = 0, callback = update })
		update()
	end
	-- Start at the end of the last line, in insert mode.
	vim.cmd("normal! G")
	vim.cmd("startinsert!")
end

return M
