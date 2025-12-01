local source = {}

-- Common CSS/web colors
local named_colors = {
	-- Basic colors
	{ name = "black", hex = "#000000" },
	{ name = "white", hex = "#ffffff" },
	{ name = "red", hex = "#ff0000" },
	{ name = "green", hex = "#00ff00" },
	{ name = "blue", hex = "#0000ff" },
	{ name = "yellow", hex = "#ffff00" },
	{ name = "cyan", hex = "#00ffff" },
	{ name = "magenta", hex = "#ff00ff" },
	{ name = "gray", hex = "#808080" },
	{ name = "grey", hex = "#808080" },
	-- Extended colors
	{ name = "orange", hex = "#ffa500" },
	{ name = "purple", hex = "#800080" },
	{ name = "pink", hex = "#ffc0cb" },
	{ name = "brown", hex = "#a52a2a" },
	{ name = "navy", hex = "#000080" },
	{ name = "teal", hex = "#008080" },
	{ name = "olive", hex = "#808000" },
	{ name = "lime", hex = "#00ff00" },
	{ name = "aqua", hex = "#00ffff" },
	{ name = "maroon", hex = "#800000" },
	{ name = "silver", hex = "#c0c0c0" },
	{ name = "gold", hex = "#ffd700" },
	{ name = "coral", hex = "#ff7f50" },
	{ name = "crimson", hex = "#dc143c" },
	{ name = "indigo", hex = "#4b0082" },
	{ name = "violet", hex = "#ee82ee" },
	{ name = "turquoise", hex = "#40e0d0" },
	{ name = "salmon", hex = "#fa8072" },
	{ name = "khaki", hex = "#f0e68c" },
	{ name = "plum", hex = "#dda0dd" },
}

source.new = function()
	local self = setmetatable({}, { __index = source })
	return self
end

function source:get_completions(context, callback)
	local items = {}
	local query = context.query:lower()
	
	-- Add named colors
	for _, color in ipairs(named_colors) do
		if color.name:find(query, 1, true) or query == "" then
			table.insert(items, {
				label = color.name,
				kind = require("blink.cmp.types").CompletionItemKind.Color,
				insertText = color.name,
				documentation = color.hex,
			})
		end
	end
	
	-- Add hex color if query starts with #
	if query:match("^#%x*$") and #query > 1 then
		table.insert(items, {
			label = query,
			kind = require("blink.cmp.types").CompletionItemKind.Color,
			insertText = query,
			documentation = "Hex color",
		})
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
