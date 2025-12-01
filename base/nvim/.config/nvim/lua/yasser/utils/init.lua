local M = {}

function M.get_icon(icon_name)
	local ICONS = {
		paste = "⍴",
		spell = "✎",
		branch = vim.env.PURE_GIT_BRANCH ~= "" and vim.fn.trim(vim.env.PURE_GIT_BRANCH) or " ",
		error = "×",
		info = "●",
		warn = "!",
		hint = "›",
		lock = "",
		success = "",
	}
	return ICONS[icon_name] or ""
end

function M.get_color(synID, what, mode)
	local value = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(synID)), what, mode)
	if mode == "cterm" then
		return tonumber(value)
	else
		return value
	end
end

return M
