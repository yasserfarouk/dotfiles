return {
	"kiddos/gemini.nvim",
	build = "pip install -U google-generativeai",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = {
		"GeminiChat",
		"GeminiChatWithContext",
		"GeminiChatToggle",
		"GeminiCode",
		"GeminiCodeWithContext",
		"GeminiCodeToggle",
	},
	keys = {
		{ "<leader>ag", "<cmd>GeminiChatToggle<cr>", desc = "Toggle Gemini Chat" },
		{ "<leader>ag", ":<C-u>'<,'>GeminiChatWithContext<cr>", mode = "v", desc = "Gemini Chat with Selection" },
		{ "<leader>aG", "<cmd>GeminiCodeToggle<cr>", desc = "Toggle Gemini Code" },
		{ "<leader>aG", ":<C-u>'<,'>GeminiCodeWithContext<cr>", mode = "v", desc = "Gemini Code with Selection" },
	},
	config = function()
		require("gemini").setup({
			-- Get your API key from https://aistudio.google.com/app/apikey
			api_key = os.getenv("GEMINI_API_KEY"),
			model = "gemini-1.5-flash", -- or "gemini-1.5-pro"
			max_output_tokens = 8192,
			temperature = 0.7,
			top_p = 0.95,
			top_k = 40,
			
			-- Window configuration
			window = {
				width = 0.5,
				height = 0.8,
				border = "rounded",
			},
			
			-- System prompts
			system_prompt = [[
You are a helpful AI assistant integrated into Neovim.
Be concise and clear in your responses.
When asked about code, provide practical, working examples.
]],
			
			-- Code generation prompt
			code_system_prompt = [[
You are an expert programmer.
Generate clean, efficient, and well-documented code.
Follow best practices and idiomatic patterns for the language.
Provide only the code unless specifically asked for explanation.
]],
		})
	end,
}
