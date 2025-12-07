local source = {}

-- Font Awesome icon names (common ones)
local fa_icons = {
	"fa-home", "fa-user", "fa-search", "fa-envelope", "fa-star", "fa-heart",
	"fa-check", "fa-times", "fa-plus", "fa-minus", "fa-arrow-up", "fa-arrow-down",
	"fa-arrow-left", "fa-arrow-right", "fa-cog", "fa-trash", "fa-edit", "fa-save",
	"fa-download", "fa-upload", "fa-file", "fa-folder", "fa-image", "fa-video",
	"fa-music", "fa-book", "fa-calendar", "fa-clock", "fa-phone", "fa-map",
	"fa-shopping-cart", "fa-credit-card", "fa-gift", "fa-camera", "fa-lock",
	"fa-unlock", "fa-key", "fa-cloud", "fa-wifi", "fa-signal", "fa-battery-full",
	"fa-bell", "fa-comment", "fa-share", "fa-link", "fa-tag", "fa-bars",
	"fa-th", "fa-list", "fa-filter", "fa-refresh", "fa-sync", "fa-power-off",
	"fa-question", "fa-info", "fa-exclamation", "fa-ban", "fa-print", "fa-globe",
	"fa-database", "fa-server", "fa-code", "fa-terminal", "fa-laptop", "fa-desktop",
	"fa-mobile", "fa-tablet", "fa-wrench", "fa-tasks", "fa-chart-bar", "fa-chart-line",
	"fa-chart-pie", "fa-bug", "fa-clipboard", "fa-pen", "fa-eraser", "fa-eye",
	"fa-eye-slash", "fa-smile", "fa-frown", "fa-thumbs-up", "fa-thumbs-down",
}

source.new = function()
	local self = setmetatable({}, { __index = source })
	return self
end

function source:get_completions(context, callback)
	local items = {}
	
	for _, icon in ipairs(fa_icons) do
		if icon:find(context.query, 1, true) then
			table.insert(items, {
				label = icon,
				kind = require("blink.cmp.types").CompletionItemKind.Text,
				insertText = icon,
			})
		end
	end
	
	callback({ is_incomplete_forward = false, is_incomplete_backward = false, items = items })
end

function source:resolve(item, callback)
	callback(item)
end

function source:execute(item, callback)
	callback(item)
end

return source
