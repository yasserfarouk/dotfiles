-- lua/yasser/utils/job.lua
--
-- Reusable background job runner with statusline feedback.
--
-- Any plugin or config can use this to run shell commands without blocking
-- Neovim, and optionally display stdout/stderr in a scratch buffer when done.
-- A shared statusline segment shows a spinner while jobs are running and a
-- failure indicator when one or more jobs have exited non-zero.
--
-- ─── Quick start ─────────────────────────────────────────────────────────────
--
--   local job = require("yasser.utils.job")
--
--   -- 1. Fire-and-forget: run silently, just update the statusline indicator
--   job.run("pandoc input.md -o output.pdf && open output.pdf")
--
--   -- 2. Show output: collect stdout/stderr and open a scratch buffer on done
--   job.run("make test", { show_output = true })
--
--   -- 3. Callbacks: react to success or failure in Lua
--   job.run("npm run build", {
--     on_success = function()
--       vim.notify("Build succeeded", vim.log.levels.INFO)
--     end,
--     on_failure = function(exit_code)
--       vim.notify("Build failed (exit " .. exit_code .. ")", vim.log.levels.ERROR)
--     end,
--   })
--
--   -- 4. Combine: show output AND run a callback
--   job.run("pytest --tb=short", {
--     show_output = true,
--     on_failure  = function() vim.notify("Tests failed", vim.log.levels.WARN) end,
--   })
--
-- ─── Statusline integration ───────────────────────────────────────────────────
--
--   Add this call wherever you build your statusline string:
--
--     require("yasser.utils.job").statusline()
--
--   Returns:
--     "⚙ "      — one job running
--     "⚙ 3 "    — three jobs running concurrently
--     "❌ "     — one or more jobs failed (persists until next run)
--     ""         — idle, all succeeded
--
-- ─── Clearing the failure indicator ──────────────────────────────────────────
--
--   The ❌ stays visible until the next job.run() call (which resets it) or
--   until you call job.clear() explicitly, e.g. bound to a key:
--
--     vim.keymap.set("n", "<leader>jc", require("yasser.utils.job").clear,
--       { desc = "clear job failure indicator" })

local M = {}

-- Module-level state shared across all callers.
-- `running` counts active jobs so concurrent runs show a correct count.
-- `failed`  counts failures since the last job.run() call (reset on each new run).
local state = {
	running = 0,
	failed  = 0,
}

-- Open collected output lines in a read-only scratch buffer split at the bottom.
-- The buffer is wiped when closed and can be dismissed with q or <Esc>.
-- @param cmd      string    the original command (shown as a header)
-- @param lines    string[]  collected stdout + stderr lines
-- @param exit_code integer  the process exit code (shown in the header)
local function show_output(cmd, lines, exit_code)
	if #lines == 0 then return end

	local buf = vim.api.nvim_create_buf(false, true) -- unlisted, scratch
	vim.bo[buf].buftype   = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile  = false

	local header    = string.format("$ %s  [exit: %d]", cmd, exit_code)
	local separator = string.rep("─", math.min(vim.o.columns - 2, #header, 80))
	local content   = { header, separator, "" }
	vim.list_extend(content, lines)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.bo[buf].modifiable = false

	vim.cmd("botright split")
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(win, buf)
	-- Cap height: enough to see output, but not more than 15 lines
	vim.api.nvim_win_set_height(win, math.min(15, #lines + 4))

	vim.keymap.set("n", "q",     "<cmd>close<cr>", { buffer = buf, silent = true })
	vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })
end

--- Run a shell command in the background.
---
--- Each call resets the failure counter so the statusline indicator starts
--- clean — ❌ from a previous run does not linger once you try again.
---
--- @param cmd  string  Shell command; executed via `sh -c`
--- @param opts? {
---   show_output?: boolean,                  -- open scratch buffer with stdout/stderr on completion (default: false)
---   on_success?:  fun(),                    -- called when exit code is 0
---   on_failure?:  fun(exit_code: integer),  -- called when exit code is non-zero
--- }
function M.run(cmd, opts)
	opts = opts or {}
	state.running = state.running + 1
	state.failed  = 0 -- clear stale failure indicator whenever a new job starts
	vim.cmd("redrawstatus")

	-- Collect output only when the caller asked for it, to avoid the overhead
	-- of string allocation on every stdout/stderr event for silent runs.
	local output = {}

	local job_opts = {
		on_exit = function(_, exit_code)
			-- on_exit fires on a libuv thread; schedule back to the main loop
			-- before touching any Neovim state.
			vim.schedule(function()
				state.running = math.max(0, state.running - 1)
				if exit_code ~= 0 then
					state.failed = state.failed + 1
					if opts.on_failure then opts.on_failure(exit_code) end
				else
					if opts.on_success then opts.on_success() end
				end
				if opts.show_output then
					show_output(cmd, output, exit_code)
				end
				vim.cmd("redrawstatus")
			end)
		end,
	}

	if opts.show_output then
		-- Both stdout and stderr are funnelled into the same list so the output
		-- buffer mirrors what you would see in a terminal (interleaved order is
		-- not guaranteed, but stderr is clearly visible).
		local function collect(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(output, line)
				end
			end
		end
		job_opts.on_stdout = collect
		job_opts.on_stderr = collect
	end

	vim.fn.jobstart(cmd, job_opts)
end

--- Statusline component.
---
--- Intended to be called from your statusline builder function on every redraw.
--- Returns a plain string — no statusline %-items — so it can be concatenated
--- directly with other segments.
---
--- Examples of what gets returned:
---   "⚙ "     one job is running
---   "⚙ 3 "   three concurrent jobs are running
---   "❌ "    at least one job failed (shown until next job.run() call)
---   ""        idle, nothing to report
function M.statusline()
	if state.running > 0 then
		local suffix = state.running > 1 and (" " .. state.running) or ""
		return "⚙" .. suffix .. " "
	elseif state.failed > 0 then
		local suffix = state.failed > 1 and (" " .. state.failed) or ""
		return "❌" .. suffix .. " "
	end
	return ""
end

--- Clear the failure indicator manually.
---
--- Useful when you want to dismiss ❌ without triggering a new run.
--- Example — bind to a key:
---
---   vim.keymap.set("n", "<leader>jc", require("yasser.utils.job").clear,
---     { desc = "clear job failure indicator" })
function M.clear()
	state.failed = 0
	vim.cmd("redrawstatus")
end

return M
