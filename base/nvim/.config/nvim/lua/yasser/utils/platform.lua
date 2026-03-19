-- Cross-platform utilities for Neovim configuration
-- This module provides platform-agnostic path handling and system detection

local M = {}

-- Platform detection
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_mac = vim.fn.has("mac") == 1 or vim.fn.has("macunix") == 1
M.is_linux = vim.fn.has("unix") == 1 and not M.is_mac
M.is_unix = vim.fn.has("unix") == 1

-- Path separator for the current platform
M.sep = M.is_windows and "\\" or "/"

-- Join path components using the correct separator for the current platform
-- Usage: platform.join("path", "to", "file") -> "path/to/file" or "path\\to\\file"
function M.join(...)
	local args = { ... }
	-- Filter out empty strings and nil values
	local parts = {}
	for _, part in ipairs(args) do
		if part and part ~= "" then
			-- Remove trailing separators from each part
			part = part:gsub("[/\\]+$", "")
			-- Remove leading separators from all parts except the first
			if #parts > 0 then
				part = part:gsub("^[/\\]+", "")
			end
			if part ~= "" then
				table.insert(parts, part)
			end
		end
	end
	return table.concat(parts, M.sep)
end

-- Get the home directory
function M.home()
	if M.is_windows then
		return os.getenv("USERPROFILE") or os.getenv("HOME") or ""
	else
		return os.getenv("HOME") or vim.fn.expand("~")
	end
end

-- Get Neovim's standard paths (cross-platform)
function M.config_dir()
	return vim.fn.stdpath("config")
end

function M.data_dir()
	return vim.fn.stdpath("data")
end

function M.cache_dir()
	return vim.fn.stdpath("cache")
end

-- Expand a path, handling ~ and environment variables
-- Also normalizes path separators for the current platform
function M.expand(path)
	if not path then
		return ""
	end

	-- First use vim's expand to handle ~ and $VAR
	local expanded = vim.fn.expand(path)

	-- Normalize separators for current platform
	if M.is_windows then
		expanded = expanded:gsub("/", "\\")
	else
		expanded = expanded:gsub("\\", "/")
	end

	return expanded
end

-- Get the temp directory
function M.temp_dir()
	if M.is_windows then
		return os.getenv("TEMP") or os.getenv("TMP") or "C:\\Temp"
	else
		return "/tmp"
	end
end

-- Get the appropriate command to open files/URLs
function M.open_cmd()
	if M.is_mac then
		return "open"
	elseif M.is_windows then
		return "start"
	else
		return "xdg-open"
	end
end

-- Get shell command prefix for sourcing files
-- On Windows with cmd.exe, we need different handling
function M.source_vimscript(filepath)
	-- Use vim.cmd.source which handles paths correctly on all platforms
	local full_path = M.join(M.config_dir(), filepath)
	vim.cmd.source(full_path)
end

-- Check if a path exists
function M.exists(path)
	return vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1
end

-- Get Python executable path (cross-platform virtual environment handling)
function M.python_venv_path(venv_name, executable)
	executable = executable or "python"
	local home = M.home()

	if M.is_windows then
		-- Windows venv structure: venv/Scripts/python.exe
		return M.join(home, venv_name, "Scripts", executable .. ".exe")
	else
		-- Unix venv structure: venv/bin/python
		return M.join(home, venv_name, "bin", executable)
	end
end

-- Get user code directory (platform-specific defaults)
function M.code_dir()
	local home = M.home()
	if M.is_windows then
		-- Common Windows locations for code
		local possible = {
			M.join(home, "code"),
			M.join(home, "Code"),
			M.join(home, "source"),
			M.join(home, "repos"),
			M.join(home, "Documents", "code"),
		}
		for _, path in ipairs(possible) do
			if M.exists(path) then
				return path
			end
		end
		return M.join(home, "code") -- Default
	else
		return M.join(home, "code")
	end
end

-- Get project base directories for telescope-project extension
-- Returns a table of { path, max_depth } entries
function M.code_dirs()
	local home = M.home()
	local dirs = {}

	if M.is_windows then
		-- Common Windows code locations
		local possible_code = {
			M.join(home, "code"),
			M.join(home, "Code"),
			M.join(home, "source"),
			M.join(home, "repos"),
			M.join(home, "Documents", "code"),
		}
		for _, path in ipairs(possible_code) do
			if M.exists(path) then
				table.insert(dirs, { path, max_depth = 4 })
				break
			end
		end
		-- OneDrive research folder
		local onedrive_research = M.join(home, "OneDrive", "research")
		if M.exists(onedrive_research) then
			table.insert(dirs, { onedrive_research, max_depth = 4 })
		end
	elseif M.is_mac then
		-- macOS paths
		table.insert(dirs, { M.join(home, "code"), max_depth = 4 })
		-- Google Drive research folder
		local gdrive_research = M.join(home, "storage", "gdrive", "research")
		if M.exists(gdrive_research) then
			table.insert(dirs, { gdrive_research, max_depth = 4 })
		end
	else
		-- Linux paths
		table.insert(dirs, { M.join(home, "code"), max_depth = 4 })
		-- Common Linux locations for additional projects
		local possible_research = {
			M.join(home, "research"),
			M.join(home, "Documents", "research"),
		}
		for _, path in ipairs(possible_research) do
			if M.exists(path) then
				table.insert(dirs, { path, max_depth = 4 })
				break
			end
		end
	end

	-- Fallback if no directories found
	if #dirs == 0 then
		table.insert(dirs, { M.join(home, "code"), max_depth = 4 })
	end

	return dirs
end

-- Get Obsidian vault directory (platform-specific)
function M.obsidian_vault()
	local home = M.home()
	if M.is_mac then
		-- macOS iCloud path
		return M.join(home, "Library", "Mobile Documents", "iCloud~md~obsidian", "Documents", "yasser")
	elseif M.is_windows then
		-- Windows: common Obsidian vault locations
		local possible = {
			M.join(home, "Documents", "Obsidian", "yasser"),
			M.join(home, "Obsidian", "yasser"),
			M.join(home, "OneDrive", "Obsidian", "yasser"),
		}
		for _, path in ipairs(possible) do
			if M.exists(path) then
				return path
			end
		end
		return M.join(home, "Documents", "Obsidian", "yasser") -- Default
	else
		-- Linux
		return M.join(home, "Documents", "Obsidian", "yasser")
	end
end

-- Get LuaRocks paths for the current platform
function M.luarocks_paths()
	local home = M.home()
	if M.is_windows then
		-- Windows LuaRocks paths
		local lr_path = M.join(home, "AppData", "Roaming", "luarocks", "share", "lua", "5.1")
		return {
			init = M.join(lr_path, "?", "init.lua"),
			module = M.join(lr_path, "?.lua"),
		}
	else
		-- Unix LuaRocks paths
		local lr_path = M.join(home, ".luarocks", "share", "lua", "5.1")
		return {
			init = lr_path .. "/?/init.lua",
			module = lr_path .. "/?.lua",
		}
	end
end

return M
