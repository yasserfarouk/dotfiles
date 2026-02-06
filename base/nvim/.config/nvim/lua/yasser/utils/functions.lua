local M = {}

function M.opencode_scratchpad()
	-- 1. Create the scratch buffer
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
	vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")

	-- 2. Open in a bottom split
	vim.cmd("botright 10split")
	vim.api.nvim_set_current_buf(bufnr)

	-- 3. The Send Logic
	local function send_to_opencode()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local text = table.concat(lines, "\n")

		if text ~= "" then
			-- Target Pane 2 specifically
			-- We use shellescape to handle special characters and quotes
			-- Send text, then Enter twice (once to submit, once to trigger opencode)
			local cmd = string.format("tmux send-keys -t .2 %s Enter Enter", vim.fn.shellescape(text))
			os.execute(cmd)
		end

		-- Close and wipe buffer
		vim.api.nvim_buf_delete(bufnr, { force = true })
	end

	-- 4. Keymaps for the scratchpad
	-- Press Enter in Normal Mode to send
	vim.keymap.set("n", "<CR>", send_to_opencode, { buffer = bufnr, silent = true })
	-- Press q or Esc to cancel
	vim.keymap.set("n", "q", ":q<CR>", { buffer = bufnr, silent = true })

	vim.cmd("startinsert")
end

function M.open_github_at_line(start_line, end_line)
	local filepath = vim.fn.expand("%:p")
	
	-- If called without arguments, use current line or visual selection
	if not start_line then
		start_line = vim.fn.line(".")
	end
	if not end_line then
		end_line = start_line
	end
	
	-- Get git root directory
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		vim.notify("Not in a git repository", vim.log.levels.ERROR)
		return
	end
	
	-- Get relative path from git root
	local relative_path = vim.fn.substitute(filepath, git_root .. "/", "", "")
	
	-- Get remote URL
	local remote_url = vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " config --get remote.origin.url")[1]
	if vim.v.shell_error ~= 0 then
		vim.notify("No remote origin found", vim.log.levels.ERROR)
		return
	end
	
	-- Get current branch or commit
	local branch = vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " rev-parse --abbrev-ref HEAD")[1]
	if branch == "HEAD" then
		-- Detached HEAD state, use commit hash
		branch = vim.fn.systemlist("git -C " .. vim.fn.shellescape(git_root) .. " rev-parse HEAD")[1]
	end
	
	-- Convert SSH URL to HTTPS if needed
	local github_url = remote_url
	github_url = github_url:gsub("^git@github%.com:", "https://github.com/")
	github_url = github_url:gsub("%.git$", "")
	
	-- Construct the full URL with line number or range
	local full_url
	if start_line == end_line then
		full_url = string.format("%s/blob/%s/%s#L%s", github_url, branch, relative_path, start_line)
	else
		full_url = string.format("%s/blob/%s/%s#L%s-L%s", github_url, branch, relative_path, start_line, end_line)
	end
	
	-- Open URL in browser
	local open_cmd
	if vim.fn.has("mac") == 1 then
		open_cmd = "open"
	elseif vim.fn.has("unix") == 1 then
		open_cmd = "xdg-open"
	elseif vim.fn.has("win32") == 1 then
		open_cmd = "start"
	else
		vim.notify("Unsupported operating system", vim.log.levels.ERROR)
		return
	end
	
	vim.fn.system(open_cmd .. " " .. vim.fn.shellescape(full_url))
	vim.notify("Opening: " .. full_url, vim.log.levels.INFO)
end

return M
