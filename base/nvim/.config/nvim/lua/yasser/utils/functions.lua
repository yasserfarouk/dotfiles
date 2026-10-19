local M = {}
local platform = require("yasser.utils.platform")

-- Note: opencode_scratchpad function removed - now using sidekick.nvim integration
-- See lua/plugins/ai.lua for the new scratchpad implementation with <leader>pj

-- Zoom toggle: maximize current window or restore to original layout
function M.zoom_toggle()
	-- Check if we have stored zoom state
	if vim.t.zoom_winrestcmd then
		-- We're zoomed, restore the original layout
		vim.cmd(vim.t.zoom_winrestcmd)
		vim.t.zoom_winrestcmd = nil
	else
		-- Not zoomed, check if there are multiple windows
		if vim.fn.winnr("$") > 1 then
			-- Store the current window layout
			vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
			-- Maximize the current window
			vim.cmd("resize")
			vim.cmd("vertical resize")
		end
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
	local relative_path = vim.fn.substitute(filepath, git_root .. platform.sep, "", "")
	
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
	
	-- Convert remote URL to HTTPS, resolving SSH config aliases
	local remote = vim.fn.trim(remote_url)
	local github_url
	local ssh_host, repo_path = remote:match("^git@([^:]+):(.+)$")
	if ssh_host then
		-- Resolve SSH config alias (e.g. "yf", "nec") to the real HostName
		local real_host = ssh_host
		local ssh_config = vim.fn.systemlist("ssh -G " .. vim.fn.shellescape(ssh_host))
		for _, line in ipairs(ssh_config) do
			local hn = line:match("^hostname%s+(.+)$")
			if hn then
				real_host = vim.fn.trim(hn)
				break
			end
		end
		repo_path = repo_path:gsub("%.git$", "")
		github_url = "https://" .. real_host .. "/" .. repo_path
	elseif remote:match("^ssh://") then
		github_url = remote:gsub("^ssh://[^@]+@([^/]+)/", "https://%1/"):gsub("%.git$", "")
	else
		-- Already HTTPS
		github_url = remote:gsub("%.git$", "")
	end
	
	-- Construct the full URL with line number or range
	local full_url
	if start_line == end_line then
		full_url = string.format("%s/blob/%s/%s#L%s", github_url, branch, relative_path, start_line)
	else
		full_url = string.format("%s/blob/%s/%s#L%s-L%s", github_url, branch, relative_path, start_line, end_line)
	end
	
	-- Open URL in browser
	local _, err = vim.ui.open(full_url)
	if err then
		vim.notify("Failed to open URL: " .. err, vim.log.levels.ERROR)
		return
	end
	vim.notify("Opening: " .. full_url, vim.log.levels.INFO)
end

return M
