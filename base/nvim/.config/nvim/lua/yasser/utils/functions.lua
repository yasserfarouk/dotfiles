local M = {}

-- Note: opencode_scratchpad function removed - now using sidekick.nvim integration
-- See lua/plugins/ai.lua for the new scratchpad implementation with <leader>pj

-- Zoom toggle: maximize current window or restore to original layout
function M.zoom_toggle()
	-- Check if we're in a zoomed state by checking if there's only one window
	if vim.fn.winnr("$") == 1 then
		-- If we're zoomed, check if we have stored window info
		if vim.t.zoom_winrestcmd then
			-- Restore the original layout
			vim.cmd(vim.t.zoom_winrestcmd)
			vim.t.zoom_winrestcmd = nil
		end
	else
		-- Store the current window layout
		vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
		-- Maximize the current window
		vim.cmd("resize")
		vim.cmd("vertical resize")
	end
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
